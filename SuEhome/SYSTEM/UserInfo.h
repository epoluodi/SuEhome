//
//  UserInfo.h
//  OldHome
//
//  Created by Stereo on 2016/11/4.
//  Copyright © 2016年 Suypower. All rights reserved.
//





#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    MALE,
    FEMALE,
} SexEnum;

typedef enum : NSUInteger {
    OLDMAN,
    WORKER,
} UserTypeEnum;

@interface UserInfo : NSObject

//登录用户名
@property (copy,nonatomic)NSString *loginName;
//登录用户名密码
@property (copy,nonatomic)NSString *loginPwd;
//昵称
@property (copy,nonatomic)NSString *nickName;
//真实姓名
@property (copy,nonatomic)NSString *realName;
//头像地址
@property (copy,nonatomic)NSString *photoUrl;
//手机号
@property (copy,nonatomic)NSString *mobile;
//用户ID
@property (copy,nonatomic)NSString *userId;
//性别
@property (assign)SexEnum sex;
//头像ID
@property (copy,nonatomic)NSString *photo;
//部门名称
@property (copy,nonatomic)NSString *departName;
//单位名称
@property (copy,nonatomic)NSString *orgName;
//部门名称id
@property (copy,nonatomic)NSString *departId;
//单位名称id
@property (copy,nonatomic)NSString *orgId;
//用户类型
@property (assign)UserTypeEnum userType;
//用户积分
@property (copy,nonatomic)NSString *score;

//用户邮箱
@property (copy,nonatomic)NSString *email;

//用户地址
@property (copy,nonatomic)NSString *addr;



@end
