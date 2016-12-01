//
//  CompanyPhoneBookViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/30.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "CompanyPhoneBookViewController.h"
#import "DBmanger.h"
#import "SelfInfoViewController.h"
#import "UserInfoSampleViewController.h"

@interface CompanyPhoneBookViewController ()

@end

@implementation CompanyPhoneBookViewController
@synthesize table,navtitle;
@synthesize P_mainId,P_mainName;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!P_mainId){
        NSDictionary *d =  [[DBmanger getIntance] getMainOrgInfo:_mainorgid orgName:_mainorgname];
        _mainorgid=  [d objectForKey:@"org_id"];
        _mainorgname =[d objectForKey:@"org_name"];
    }
    else
    {
        _mainorgid = P_mainId;
        _mainorgname = P_mainName;
    }
    
    
    navtitle.title=_mainorgname;
    _phonebookds = [[PhoneBookDataSource alloc] init:_mainorgid MODE:DEFAULTMODE];
    
    UINib *nib= [UINib nibWithNibName:@"personcell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell"];
    
    _phonebookds.delegate = self;
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = _phonebookds;
    table.delegate = _phonebookds;
    table.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);

    
    // Do any additional setup after loading the view.
}


#pragma mark PhoneBook Delegate
-(void)selectCell:(NSDictionary *)CellData
{
    CompanyPhoneBookViewController *newcpbvc;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    newcpbvc = [storyboard instantiateViewControllerWithIdentifier:@"CompanyPhoneBookViewController"];
    
    if ([[CellData objectForKey:@"type"] isEqualToString:@"1"])
    {
        T_ORG *to = [CellData objectForKey:@"obj"];
        newcpbvc.P_mainId = to.org_id;
        newcpbvc.P_mainName = to.org_name;
        [self.navigationController pushViewController:newcpbvc animated:YES];
    }else if([[CellData objectForKey:@"type"] isEqualToString:@"2"])
    {
        T_DEPT *td =[CellData objectForKey:@"obj"];
        newcpbvc.P_mainId = td.dept_id;
        newcpbvc.P_mainName = td.dept_name;
        [self.navigationController pushViewController:newcpbvc animated:YES];
    }else if([[CellData objectForKey:@"type"] isEqualToString:@"3"])
    {
        T_Member *tm =[CellData objectForKey:@"obj"];
        if ([[[AppInfo getInstance] getUserInfo].userId isEqualToString:tm.user_id])
        {
            
            SelfInfoViewController *selfinfovc = (SelfInfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SelfInfoViewController"];
            [self.navigationController pushViewController:selfinfovc animated:YES];
            return;
        }else
        {
            UserInfoSampleViewController *_UserInfoSampleViewController =[storyboard instantiateViewControllerWithIdentifier:@"UserInfoSampleViewController"];
            _UserInfoSampleViewController.T_member= tm;
            [self.navigationController pushViewController:_UserInfoSampleViewController animated:YES];
        }
    }
    
    
}


-(void)NothingData
{
    [self.navigationController popViewControllerAnimated:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有数据" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    return;
}

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
