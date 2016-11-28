//
//  AutoLogin.m
//  SuEhome
//
//  Created by Stereo on 2016/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "AutoLogin.h"
#import "LoginViewController.h"
@implementation AutoLogin
@synthesize VC;


-(void)autoLogin
{
    NSString *username = [[AppInfo getInstance] getUserInfo].loginName;
    NSString *userpwd = [[AppInfo getInstance] getUserInfo].loginPwd;
    
    if ([username isEqualToString:@""] || [userpwd isEqualToString:@""])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginvc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [VC presentViewController:loginvc animated:YES completion:nil];
        return;
    }
    
    [self login:username pwd:userpwd];
    
}

-(void)login:(NSString *)username pwd:(NSString *)pwd
{
    

    dispatch_async(GLOBALQ, ^{
        ReturnData *r;
        HttpLogin *httplogin = [[HttpLogin alloc] init:username pwd:pwd];
        r = [httplogin Login];
        
        if (r.returnCode==0)
        {
            [USER_DEFAULT setObject:username forKey:@"username"];
            [USER_DEFAULT setObject:pwd forKey:@"userpwd"];
            [USER_DEFAULT synchronize];
            [[AppInfo getInstance] getUserInfo].loginName =username;
            [[AppInfo getInstance] getUserInfo].loginPwd  =pwd;
        }
        else{
            MAIN(^{
                [VC Loginfail:r.returnMsg];
            });
            return ;
        }
        
        
        
        HttpUserInfo *httpuserinfo = [[HttpUserInfo alloc] init];
        r =  [httpuserinfo getBaseUserInfo];
        
        if (r.returnCode==0)
        {
            switch ([[AppInfo getInstance] getUserInfo].userType) {
                case OLDMAN://老年人版本
                    r =  [httpuserinfo getFamilyList];
                    if (r.returnCode == 0)
                    {
                        MAIN(^{
                            [VC LoginSuccess];

                        });
                        return;
                    }else
                    {
                        MAIN(^{
                            [VC Loginfail:r.returnMsg];
                        });
                        return;
                    }
                    break;
                    
                case WORKER://工作人员版本
                    
                    
                    
                    
                    break;
            }
            
        }
        else{
            MAIN(^{
                [VC Loginfail:r.returnMsg];
            });
            return ;
        }
        
        
    

    });
    
    
    
}



@end
