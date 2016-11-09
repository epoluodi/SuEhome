//
//  LoginViewController.h
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCommon.h"
#import "AutoLogin.h"
@interface LoginViewController : UIViewController<AutoLoginDelegate>
{
    MBProgressHUD *hud;
}

@property (weak, nonatomic) IBOutlet UIImageView *nickimg;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *userpwd;
@property (weak, nonatomic) IBOutlet UIButton *btnlogin;

@property (weak, nonatomic) IBOutlet UIView *loginview;

- (IBAction)ClickLogin:(id)sender;

@end
