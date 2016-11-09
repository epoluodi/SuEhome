//
//  SettingViewController.m
//  OldHome
//
//  Created by Stereo on 2016/11/3.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "SettingViewController.h"
#import "CommonCellNoImg.h"
#import <Common/PublicCommon.h>
@interface SettingViewController ()
{
    MBProgressHUD *hud;
}
@end

@implementation SettingViewController
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINib *nib = [UINib nibWithNibName:@"commoncellnoimg" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell"];
    
    table.backgroundColor = [UIColor clearColor];
    table.delegate = self;
    table.dataSource = self;
    table.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
    
    
    // Do any additional setup after loading the view.
}





#pragma mark tabldedelgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
     
        case 1:
            return 2;
        case 0:
        case 2:
            return 1;
    }
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    
    
    if (section == 2)
    {
        v.frame = CGRectMake(0, 0, [PublicCommon GetScreen].size.width, 70);
        UIButton *btnexit = [[UIButton alloc] init];
        btnexit.frame = CGRectMake(0, 25, [PublicCommon GetScreen].size.width, 45);
        [btnexit setBackgroundColor:[UIColor whiteColor]];
        
        UIImage *back1 = [PublicCommon createImageWithColor:[UIColor whiteColor] Rect:CGRectMake(0, 0, 100, 100)];
        UIImage *back2 = [PublicCommon createImageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.03] Rect:CGRectMake(0, 0, 100, 100)];
    
        btnexit.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
        btnexit.layer.borderWidth = 0.2;
//        btnexit.layer.cornerRadius=8;
//        btnexit.layer.masksToBounds=YES;
        [btnexit setBackgroundImage:back1 forState:UIControlStateNormal];
        [btnexit setBackgroundImage:back2 forState:UIControlStateHighlighted];
        [btnexit setTitle:@"退出登录" forState:UIControlStateNormal];
        [btnexit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [v addSubview:btnexit];
    }
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
        return 70;
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    v.frame = CGRectMake(0, 0, [PublicCommon GetScreen].size.width, 35);
    v.backgroundColor = [UIColor clearColor];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(16, 5, 200, 30);
    lab.font = [UIFont systemFontOfSize:14];
    switch (section) {
        case 0:
            lab.text= @"通知设置";
            break;
        case 1:
            lab.text= @"通用设置";
            break;
        case 2:
            lab.text= @"账号和安全";
            break;
    }

    lab.textColor = [UIColor grayColor];
    [v addSubview:lab];
    return v;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCellNoImg *cell = [table dequeueReusableCellWithIdentifier:@"cell"];
    
    
    switch (indexPath.section) {
            
        case 0:
            [cell setListMode:SWITCH];
            

            [cell setCellSelectState:            [UIApplication sharedApplication].isRegisteredForRemoteNotifications];
            cell.listtitle.text = @"推送通知";
            break;
        case 1:
            if (indexPath.row==0){
                [cell setListMode:INDICATOR];
                cell.listtitle.text = @"字体大小";
            }else  if (indexPath.row==1){
                [cell setListMode:INDICATOR];
                cell.listtitle.text = @"清除缓存";
            }
            break;
        case 2:
            [cell setListMode:INDICATOR];
            cell.listtitle.text = @"修改密码";
            break;
     
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            
        case 0:
        
            break;
        case 1:
            if (indexPath.row==0){
          
            }else  if (indexPath.row==1){
                [self ClearCacheFile];
            }
            break;
        case 2:

            break;
            
    }
}


//清除缓存
-(void)ClearCacheFile
{
    //显示loadview

    hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"正在清理";
    [hud show:YES];
    NSString *path = [FileCommon getCacheDirectory];
    dispatch_async(GLOBALQ, ^{
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
        
        //清除文件缓存
        for (NSString *p in files) {
            NSError *error;
            if ([p containsString:@"aac"] || [p containsString:@"jpg"]){
                NSString *filepath = [path stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
                    [[NSFileManager defaultManager] removeItemAtPath:filepath error:&error];
                }
            }
        }
        
        
        dispatch_async(MAINQ ,^{
            [hud hide:YES];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"清理完成" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        });
        
        
    });
    
    
    
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
