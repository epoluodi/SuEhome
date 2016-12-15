//
//  AppCommon.h
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//



///定义不同机型
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)



//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
#define GLOBALQ dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define MAINQ dispatch_get_main_queue()

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]



//模拟器判断
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR true
#elif TARGET_OS_IPHONE
#define SIMULATOR false
#endif


//当前APP相关定义
#define APPCOLOR UIColorFromRGB(0xFF4500) //主色调标题栏，button

#import "ServerInfo.h"
#import "MBProgressHUD.h"
#import "AppInfo.h"
#import "DBmanger.h"
#import <Common/FileCommon.h>
#import "STCommon.h"


//系统定义通知
#define Notification_CLOSEVIEWCONTROLLEREVENT @"closeViewControllerNotification"  //关闭webcontroller 事件
#define Notification_CLOSEVIEWCONTROLLER @"closeViewController"      //关闭webcontroller

#define Notification_USER_LOGOUT @"USERLOGOUT"                  //当前用户注销
#define Notification_MQTTDISCONNECT @"MQTTDISCONNECT"    //mqtt 连接断开
#define Notification_MQTTCONNECT @"MQTTCONNECT"                 //mqtt 连接
#define Notification_MQTTRECEVEING @"MQTTRECEVEING"         //mqtt 接收

