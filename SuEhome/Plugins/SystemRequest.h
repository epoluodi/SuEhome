//
//  SystemRequest.h
//  SuEhome
//
//  Created by Stereo on 2016/11/10.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "CDVPlugin.h"
#import "AppCommon.h"
@interface SystemRequest : CDVPlugin
{
    
}

//设置标题
-(void)title:(CDVInvokedUrlCommand *)command;

//设置navbar 状态
-(void)navbar:(CDVInvokedUrlCommand *)command;

//获取用户信息
-(void)getLoginUser:(CDVInvokedUrlCommand *)command;
@end
