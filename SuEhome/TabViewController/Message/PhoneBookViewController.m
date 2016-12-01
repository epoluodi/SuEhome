//
//  PhoneBookViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/30.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "PhoneBookViewController.h"
#import "PersonCell.h"
#import "AppCommon.h"
#import "DBmanger.h"
#import "T_Member+CoreDataClass.h"
#import "SelfInfoViewController.h"
#import "UserInfoSampleViewController.h"

@interface PhoneBookViewController ()

@end

@implementation PhoneBookViewController
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchbar= [[UISearchBar alloc] init];
    searchbar.placeholder=@"搜索";
    searchbar.showsCancelButton=NO;
    searchbar.barTintColor = UIColorFromRGB(0xEAEAEA);
    //    searchbar.inputAccessoryView =[PublicCommon getInputToolbar:self sel:@selector(closeInputborad)];
    searchbar.delegate=self;
    IsSearchMode = NO;
    [self initSearchBackView];
    
    UINib *nib= [UINib nibWithNibName:@"personcell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell"];
    
    table.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);

    // Do any additional setup after loading the view.
    
    memberlists = [[DBmanger getIntance] getMembersForDept:[[AppInfo getInstance] getUserInfo].departId ];
    table.delegate = self;
    table.dataSource= self;
}


//初始化搜索view
-(void)initSearchBackView
{
    
    
    searchview = [[SearchView alloc] init:self.view];
    _backview = [searchview getBackView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeInputborad)];
    [_backview addGestureRecognizer:tap];
    
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
        
    }];
    
    
}




#pragma mark tabledelegate






-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
        return 50;
    else
        return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return searchbar;
    else
    {
        UILabel *labpy = [[UILabel alloc] init];
        labpy.text = [NSString stringWithFormat:@"   %@",[[AppInfo getInstance]getUserInfo ].departName];
        labpy.textColor =UIColorFromRGB(0x999999);
        labpy.backgroundColor = UIColorFromRGB(0xEAEAEA);
        return labpy;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 2;
    return memberlists.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PersonCell *cell = [table dequeueReusableCellWithIdentifier:@"cell"];

    if (indexPath.section  == 0)
    {
        switch (indexPath.row) {
            case 0:
                cell.nickname.text =@"群聊";
                cell.nickimg.image = [UIImage imageNamed:@"group"];
                break;
            case 1:
                cell.nickname.text =@"企业通讯录";
                cell.nickimg.image = [UIImage imageNamed:@"family"];
                break;

        }
    }else if (indexPath.section==1)
    {
        T_Member * tmember =   memberlists[indexPath.row];
        cell.nickname.text =tmember.nick_name;
        [cell.nickimg setMediaIdLoadImg:tmember.org_id filesize:@"_40"];
    }

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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if(indexPath.section == 0)
    {
        if (indexPath.row == 1)
        {
            [self performSegueWithIdentifier:@"showcompanyphonebook" sender:nil];
        }
        return;
    }
    
    
    if (indexPath.section ==1)
    {
        T_Member * tmember =   memberlists[indexPath.row];
        if ([[[AppInfo getInstance] getUserInfo].userId isEqualToString:tmember.user_id])
        {
            
            SelfInfoViewController *selfinfovc = (SelfInfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SelfInfoViewController"];
            [self.navigationController pushViewController:selfinfovc animated:YES];
            return;
        }else
        {
            UserInfoSampleViewController *_UserInfoSampleViewController =[storyboard instantiateViewControllerWithIdentifier:@"UserInfoSampleViewController"];
            _UserInfoSampleViewController.T_member= tmember;
            [self.navigationController pushViewController:_UserInfoSampleViewController animated:YES];
        }
        
    }
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
