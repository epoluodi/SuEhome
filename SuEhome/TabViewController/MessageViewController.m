//
//  MessageViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/23.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MessageViewController.h"
#import <Common/PublicCommon.h>


@interface MessageViewController ()

@end




@implementation MessageViewController
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    table.backgroundColor = [UIColor clearColor];
    table.delegate=self;
    table.dataSource= self;
    searchbar= [[UISearchBar alloc] init];
    searchbar.placeholder=@"搜索";
    searchbar.showsCancelButton=NO;
    searchbar.barTintColor = UIColorFromRGB(0xEAEAEA);
//    searchbar.inputAccessoryView =[PublicCommon getInputToolbar:self sel:@selector(closeInputborad)];
    searchbar.delegate=self;
    
    
    cancelButton = [searchbar valueForKey:@"_cancelButton"];

    IsSearchMode = NO;
    [self initSearchBackView];
    
    [self InitRightBtn];
    // Do any additional setup after loading the view.
}


//关闭键盘恢复ui
-(void)closeInputborad
{
    [searchbar resignFirstResponder];
    [self searchBarCancelButtonClicked:searchbar];
}



//初始化搜索view
-(void)initSearchBackView
{

    
    searchview = [[SearchView alloc] init:self.tabBarController.view];
    _backview = [searchview getBackView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeInputborad)];
    [_backview addGestureRecognizer:tap];
    
}



-(void)InitRightBtn
{
    if ([[AppInfo getInstance] getUserInfo].userType == OLDMAN)
    {
        rightbtn1 = [[UIButton alloc] init];
        [rightbtn1 setImage:[UIImage imageNamed:@"t3_1"] forState:UIControlStateNormal];
        rightbtn1.frame = CGRectMake([PublicCommon GetALLScreen].size.width - 16-24, 22 -12, 24, 24);
        [self.navigationController.navigationBar addSubview:rightbtn1];
        [rightbtn1  addTarget:self action:@selector(ClickContract) forControlEvents:UIControlEventTouchUpInside];
        
    }else if([[AppInfo getInstance] getUserInfo].userType == WORKER)
    {
        rightbtn1 = [[UIButton alloc] init];
        [rightbtn1 setImage:[UIImage imageNamed:@"t3_3"] forState:UIControlStateNormal];
        rightbtn1.frame = CGRectMake([PublicCommon GetALLScreen].size.width - 16-24, 22 -12, 24, 24);
        [self.navigationController.navigationBar addSubview:rightbtn1];
        [rightbtn1  addTarget:self action:@selector(ClickContract) forControlEvents:UIControlEventTouchUpInside];
        
        rightbtn2 = [[UIButton alloc] init];
        [rightbtn2 setImage:[UIImage imageNamed:@"t3_1"] forState:UIControlStateNormal];
        rightbtn2.frame = CGRectMake([PublicCommon GetALLScreen].size.width - 16-24 - 10 - 24, 22 -12, 24, 24);
        [self.navigationController.navigationBar addSubview:rightbtn2];
        [rightbtn2  addTarget:self action:@selector(ClickPhoneBook) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
}


-(void)ClickPhoneBook
{
      [self performSegueWithIdentifier:@"PhoneBookViewController" sender:self];
}

-(void)ClickContract
{
    [self performSegueWithIdentifier:@"showfamilylist" sender:self];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavTitleHide:NO];
    [self setNavTitle:@"消息"];
    if (rightbtn1)
        rightbtn1.hidden=NO;
    if (rightbtn2)
        rightbtn2.hidden=NO;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (rightbtn1)
        rightbtn1.hidden=YES;
    if (rightbtn2)
        rightbtn2.hidden=YES;
}




#pragma mark -UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.tabBarController.view addSubview:_backview];
    __weak __typeof(self) weakself = self;
    [UIView animateWithDuration:0.5 animations:^{
         table.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        //1.
        weakself.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
        
//        searchBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
        _backview.alpha=0.9;
 
        [mainviewcontroller setStatusbarMode:UIStatusBarStyleDefault];
        [weakself setNeedsStatusBarAppearanceUpdate];
        searchBar.showsCancelButton = YES;
        cancelButton.enabled=YES;
        IsSearchMode = YES;
//        //1.执行动画

    }];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    __weak __typeof(self) weakself = self;
    [UIView animateWithDuration:0.4 animations:^{
        table.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //1.
        weakself.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        _backview.alpha=0;
        //        searchBar.transform = CGAffineTransformIdentity;
        //2.
        searchBar.showsCancelButton = NO;
        [searchBar endEditing:YES];
        IsSearchMode = NO;
        //3.
        searchBar.text=@"";
    } completion:^(BOOL finished) {
        [_backview removeFromSuperview];
        [mainviewcontroller setStatusbarMode:UIStatusBarStyleLightContent];
        [weakself setNeedsStatusBarAppearanceUpdate];
        
    }];


}





#pragma mark tabledelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    return searchbar;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text=@"123";
    return cell;
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    if (IsSearchMode)
        return UIStatusBarStyleDefault;
    else
        return UIStatusBarStyleLightContent;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
