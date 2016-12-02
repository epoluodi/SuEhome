//
//  ContactViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/24.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "ContactViewController.h"
#import "DBmanger.h"
#import "UserInfoSampleViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    table.backgroundColor = [UIColor clearColor];
    table.sectionIndexBackgroundColor = [UIColor clearColor];
    searchbar= [[UISearchBar alloc] init];
    searchbar.placeholder=@"搜索";
    searchbar.showsCancelButton=NO;
    searchbar.barTintColor = UIColorFromRGB(0xEAEAEA);
    //    searchbar.inputAccessoryView =[PublicCommon getInputToolbar:self sel:@selector(closeInputborad)];
    searchbar.delegate=self;
    
    
    UINib *nib= [UINib nibWithNibName:@"personcell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell"];
    
    table.delegate=self;
    table.dataSource= self;
    IsSearchMode = NO;
    [self initSearchBackView];
    
    friendlist = [[NSMutableArray alloc] init];
    [self loadContract];
    

    // Do any additional setup after loading the view.
}

//搜索点击选中
-(void)SelectCell:(NSManagedObject *)Obj
{
    [self searchBarCancelButtonClicked:searchbar];
    
    T_friendlist * tfriend =(T_friendlist *)Obj;
    
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserInfoSampleViewController *_UserInfoSampleViewController =[storyborad instantiateViewControllerWithIdentifier:@"UserInfoSampleViewController"];
    _UserInfoSampleViewController.T_Friend =tfriend;
    [self.navigationController pushViewController:_UserInfoSampleViewController animated:YES];
}
//读取用户数据
-(void)loadContract
{
    PYlist = [[DBmanger getIntance] getFiendlistGroupCoountForPingYing];
    selectlistpy = [[NSMutableArray alloc] init];
    for (NSDictionary *fpy in PYlist) {
        [selectlistpy addObject:[fpy objectForKey:@"fpy" ] ];
        
        NSArray *_list = [[DBmanger getIntance] getFiendListAllForPY:[fpy objectForKey:@"fpy" ]];
        [friendlist addObject:_list];
    }
    [table reloadData];
    
}
//初始化搜索view
-(void)initSearchBackView
{
    
    
    searchview = [[SearchView alloc] init:self.view];
    _backview = [searchview getBackView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeInputborad)];
//    [_backview addGestureRecognizer:tap];
    
}

//关闭键盘恢复ui
-(void)closeInputborad
{
    [searchbar resignFirstResponder];
    [self searchBarCancelButtonClicked:searchbar];
}



#pragma mark -UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.view addSubview:_backview];
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
        if (_stable)
        {
            [_stable removeFromSuperview];
            _stable=nil;
        }
        
    }];
    
    
}


//搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSArray *reslut = [[DBmanger getIntance] searchFriendForKey:searchBar.text];
    _stable = [[SearchTableView alloc] init:reslut];
    _stable.frame = CGRectMake(0, 0, _backview.frame.size.width, _backview.frame.size.height);
    _stable.VC=self;
    [_backview addSubview:_stable];
    
}



#pragma mark tabledelegate


-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{


    if (selectlistpy)
        return selectlistpy;
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    return index;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (PYlist)
        return PYlist.count +1;
    return 1;
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
        return 50;
    else
        return 25;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return searchbar;
    else
    {
        UILabel *labpy = [[UILabel alloc] init];
        labpy.text = [NSString stringWithFormat:@"  %@",selectlistpy[section-1]];
        labpy.backgroundColor = UIColorFromRGB(0xEAEAEA);
        return labpy;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 0;
    return ((NSArray *)friendlist[section-1]).count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PersonCell *cell = [table dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *_arr = friendlist[indexPath.section-1];
    T_friendlist * tfriend =_arr[indexPath.row];
    cell.nickname.text =tfriend.nickname;
    [cell.nickimg setMediaIdLoadImg:tfriend.picid filesize:@"_40"];
    [cell.nickimg setRadius];
    
    return cell;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *_arr = friendlist[indexPath.section-1];
    T_friendlist * tfriend =_arr[indexPath.row];
    
    UIStoryboard *storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserInfoSampleViewController *_UserInfoSampleViewController =[storyborad instantiateViewControllerWithIdentifier:@"UserInfoSampleViewController"];
    _UserInfoSampleViewController.T_Friend =tfriend;
    [self.navigationController pushViewController:_UserInfoSampleViewController animated:YES];
}

#pragma mark -





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
