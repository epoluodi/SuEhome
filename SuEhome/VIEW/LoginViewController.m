//
//  LoginViewController.m
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "LoginViewController.h"
#import <Common/PublicCommon.h>
#import "MainRootViewController.h"



@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize username,userpwd;
@synthesize loginview;
@synthesize btnlogin;
@synthesize nickimg;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    nickimg.layer.cornerRadius=8;
    nickimg.layer.masksToBounds=YES;
    
    btnlogin.layer.cornerRadius=8;
    btnlogin.layer.masksToBounds=YES;
    
    
    UIView *_lineview = [[UIView alloc] init];
    _lineview.frame= CGRectMake(16, 105/2, [PublicCommon GetScreen].size.width -32, 1);
    _lineview.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.15f];
    [loginview addSubview:_lineview];
    
    UIImage *back1 = [PublicCommon createImageWithColor:APPCOLOR Rect:CGRectMake(0, 0, 100, 100)];
    UIImage *back2 = [PublicCommon createImageWithColor:UIColorFromRGB(0xFF6347) Rect:CGRectMake(0, 0, 100, 100)];
    
    [btnlogin setBackgroundImage:back1 forState:UIControlStateNormal];
    [btnlogin setBackgroundImage:back2 forState:UIControlStateHighlighted];
    
    username.inputAccessoryView = [PublicCommon getInputToolbar:self sel:@selector(closeInputboard)];
    userpwd.inputAccessoryView = [PublicCommon getInputToolbar:self sel:@selector(closeInputboard)];
    
    
    //显示 登录名称
    username.text = [[AppInfo getInstance] getUserInfo].loginName;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeInputboard)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}


-(void)closeInputboard
{
    [username resignFirstResponder];
    [userpwd resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//  
//}


- (IBAction)ClickLogin:(id)sender {
    
    
    [self closeInputboard];
    if ([username.text isEqualToString:@""] )
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入账号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([userpwd.text isEqualToString:@""] )
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    
    AutoLogin *autologin = [[AutoLogin alloc] init];
    autologin.VC=self;
    [autologin login:username.text pwd:userpwd.text];
    
    
    
//    [self performSegueWithIdentifier:@"showMainRoot" sender:self];
}


-(void)LoginSuccess
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainRootViewController *mainvc = [storyboard instantiateViewControllerWithIdentifier:@"MainRootViewController"];
    
    
    [UIApplication sharedApplication].keyWindow.rootViewController = mainvc;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

-(void)Loginfail:(NSString *)msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
