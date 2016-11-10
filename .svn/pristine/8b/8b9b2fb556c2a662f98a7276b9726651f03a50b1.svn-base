//
//  SystemRequest.m
//  SuEhome
//
//  Created by Stereo on 2016/11/10.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "SystemRequest.h"
#import "CDVViewController.h"


@implementation SystemRequest


-(void)title:(CDVInvokedUrlCommand *)command
{
    CDVViewController *cdv = (CDVViewController *)self.viewController;
    [self.commandDelegate runInBackground:^{
        [cdv OnMessage:@"title" command:command];
    }];
 
}


-(void)navbar:(CDVInvokedUrlCommand *)command
{
    CDVViewController *cdv = (CDVViewController *)self.viewController;
    [self.commandDelegate runInBackground:^{
        [cdv OnMessage:@"navbar" command:command];
    }];
}

-(void)getLoginUser:(CDVInvokedUrlCommand *)command
{

    

    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[AppInfo getInstance] getUserInfo].realName,@"userName",
                              [[AppInfo getInstance] getUserInfo].photo,@"avatar",
                              [[AppInfo getInstance] getUserInfo].userId,@"userId",
                              [[AppInfo getInstance] getUserInfo].nickName,@"nickName",
                              [[AppInfo getInstance] getUserInfo].departId,@"deptId",
                              [[AppInfo getInstance] getUserInfo].orgId,@"orgId",
                              [NSString stringWithUTF8String:[[AppInfo getInstance] getAppRunInfo]->TOEKN],@"token",
                              [[AppInfo getInstance] getUserInfo].photoUrl,@"photoUrl",
                              @"2",@"deviceType",nil];
        
        pluginResult  =[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];


    
}
@end
