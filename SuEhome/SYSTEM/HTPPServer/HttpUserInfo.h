//
//  HttpUserInfo.h
//  SuEhome
//
//  Created by 程嘉雯 on 16/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseHttp.h"
#import "AppInfo.h"

//用户基本信息
#define getperson  [NSString stringWithFormat:@"%@person/get",AppUrl]

//用户基本信息
#define getfamilylist  [NSString stringWithFormat:@"%@person/families",AppUrl]

//更新用户信息
#define updateuserinfo [NSString stringWithFormat:@"%@person/update",AppUrl]


@interface HttpUserInfo : BaseHttp


//获取用户基本信息
-(ReturnData *)getBaseUserInfo;

//获取用户亲情好友
-(ReturnData *)getFamilyList;


//更新用户信息
-(ReturnData *)updateUserInfo;


@end
