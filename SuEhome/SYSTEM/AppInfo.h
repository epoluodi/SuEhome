//
//  AppInfo.h
//  OldHome
//
//  Created by Stereo on 2016/11/4.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "Emj.h"
#define DBVER 2


struct AppRunInfo {
    const char * TOEKN;
    int deviceType;
};

@interface AppInfo : NSObject
{
    UserInfo *_userinfo;
    int _dbver;
    struct AppRunInfo appRunInfo;
}
+(instancetype)getInstance;





//获得当前登录用户信息
-(UserInfo *)getUserInfo;
-(struct AppRunInfo *)getAppRunInfo;
-(void)ClearInfo;

@end
