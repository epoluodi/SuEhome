//
//  UserInfoSampleViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/25.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "UserInfoSampleViewController.h"
#import <Common/PublicCommon.h>
#import "UserInfoHeadCell.h"

@interface UserInfoSampleViewController ()

@end

@implementation UserInfoSampleViewController
@synthesize table;
@synthesize navtitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    navtitle.title = @"详细资料";
    


    UINib *nib = [UINib nibWithNibName:@"commoncellnoimg" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    nib =[UINib nibWithNibName:@"userinfoheadcell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell"];
    
    table.backgroundColor = [UIColor clearColor];
    table.delegate = self;
    table.dataSource = self;
    
    // Do any additional setup after loading the view.
}




#pragma mark tabledelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            if (_T_member)
                return 3;
            if (_T_Friend)
                return 2;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0)
        return 100;
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCellNoImg *cell2;
    if (indexPath.section == 0)
    {
        
        UserInfoHeadCell *cell = [table dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_T_Friend){
            cell.nickName = _T_Friend.nickname;
            cell.nickSex = _T_Friend.gender;
            [cell.nickimg setMediaIdLoadImg:_T_Friend.picid filesize:@"_120"];
        }
        if (_T_member)
        {
            cell.nickName = _T_member.nick_name;
            cell.nickSex = _T_member.gender;
            [cell.nickimg setMediaIdLoadImg:_T_member.pic_id filesize:@"_120"];
        }
        [cell setUserInfo];
        [cell.nickimg setRadius];
       
        return cell;
    }
    else if (indexPath.section == 1)
    {
        cell2 = [table dequeueReusableCellWithIdentifier:@"cell2"];
        switch (indexPath.row) {
            case 0:
                [cell2 setListMode:NOINDICATOR];
                if (_T_member)
                {
                    [cell2 setListMemo:[[DBmanger getIntance] getOrgName:_T_member.org_id]];
                }else
                    [cell2 setListMemo:[[AppInfo getInstance] getUserInfo].orgName];
                cell2.listtitle.text = @"单位";
                [cell2 setCellSelectState:NO];
                
                break;
                
            case  1:
                [cell2 setListMode:NOINDICATOR];
                if (_T_member)
                {
                    [cell2 setListMemo:[[DBmanger getIntance] getDeptName:_T_member.dept_id]];
                }else
                    [cell2 setListMemo:[[AppInfo getInstance] getUserInfo].departName];
                cell2.listtitle.text = @"部门";
                [cell2 setCellSelectState:NO];
                break;
            case  2:
                [cell2 setListMode:INDICATOR];
                if (_T_member)
                {
                    [cell2 setListMemo:_T_member.phone];
                }
                cell2.listtitle.text = @"手机号";
                [cell2 setCellSelectState:NO];
                cell2.selectionStyle = UITableViewCellSelectionStyleDefault;
                break;
        }
        return cell2;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

        return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
        return 0;
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section== 0 )
        return nil;
    UIButton *btnok = [[UIButton alloc] init];
    
    btnok.frame= CGRectMake(20, 30, [PublicCommon GetALLScreen].size.width - 40, 50);
    
    UIImage *back1 = [PublicCommon createImageWithColor:APPCOLOR Rect:CGRectMake(0, 0, 100, 100)];
    UIImage *back2 = [PublicCommon createImageWithColor:UIColorFromRGB(0xFF6347) Rect:CGRectMake(0, 0, 100, 100)];
    
    [btnok setBackgroundImage:back1 forState:UIControlStateNormal];
    [btnok setBackgroundImage:back2 forState:UIControlStateHighlighted];
    
    btnok.layer.cornerRadius=8;
    btnok.layer.masksToBounds=YES;
    [btnok addTarget:self action:@selector(clickSend) forControlEvents:UIControlEventTouchUpInside];
    [btnok setTitle:@"发送消息" forState:UIControlStateNormal];
    UIView *v = [[UIView alloc] init];
    [v addSubview:btnok];
    
    return v;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 1)
    {
        if (indexPath.row == 2)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_T_member.phone];
                //            NSLog(@"str======%@",str);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"加入手机通讯录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alert addAction:action1];
//            [alert addAction:action2];
            [alert addAction:action3];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

#pragma mark -



//发送消息
-(void)clickSend
{
    
    
}


//写入系统通讯录



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
