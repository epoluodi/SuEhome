//
//  MainRootViewController.h
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCommon.h"
#import "MQTT.h"
#import "MessageControll.h"


@interface MainRootViewController : UINavigationController<UINavigationControllerDelegate,MQTTDelegate>
{
    BOOL isCloseEvent;
    NSString *_callJS ,* _jsArg;
    UIViewController * _oldVC;
    
    UIStatusBarStyle statusbarstyle;
    
    MQTT *_mqtt;
   
    
}

@property (strong,nonatomic) UILabel *labtitle;
@property (weak,nonatomic) UITabBarController *rootViewController;

-(void)LogOut;
-(void)setStatusbarMode:(UIStatusBarStyle) statusmode;
@end
