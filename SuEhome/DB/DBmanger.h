//
//  DBmanger.h
//  DyingWish
//
//  Created by xiaoguang yang on 15-4-2.
//  Copyright (c) 2015年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "T_friendlist+CoreDataClass.h"
#import "T_ORG+CoreDataClass.h"
#import "T_DEPT+CoreDataClass.h"
#import "T_Member+CoreDataClass.h"
#import "T_ChatMessage+CoreDataClass.h"
#import "AppCommon.h"



@interface DBmanger : NSObject
{
    NSManagedObjectContext *mangedcontext;
    NSManagedObjectModel *mangedobjectmodel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
}




-(instancetype)initDB;
+(instancetype)getIntance;


//添加亲情好友
-(void)addFriendList:(NSDictionary *)frienddict;
-(void)deleAllFriendList;//删除所有亲情好友
-(NSArray *)getFiendlistGroupCoountForPingYing;//获得好友拼音分组
-(NSArray *)getFiendListAllForPY:(NSString *)fpy;//获得好友用户根据拼音
-(NSArray *)searchFriendForKey:(NSString *)key;//根据关键字获取用户信息


//企业通讯录
-(void)deletAllOrg;//删除所有组织记录
-(void)addORG:(NSDictionary *)orgdict;//添加组织信息 

-(void)deletAllDept;//删除所有部门信息
-(void)addDEPT:(NSDictionary *)deptdict;//添加部门

-(void)deletAllMember;//删除成员信息
-(void)addMember:(NSDictionary *)memberdict;//添加成员信息

-(NSArray *)getMembersForDept:(NSString *)deptid;//根据部门id 获取部门成员信息
-(NSString *)getOrgName:(NSString *)orgid;//根据单位ID 获取单位名称
-(NSString *)getDeptName:(NSString *)deptid;//根据部门id 获取部门名称

//获取当前根单位信息 
-(NSDictionary *)getMainOrgInfo:(NSString *)orgid orgName:(NSString *)orgname;
-(NSArray *)getOrgForOrg:(NSString *)orgid;//根据id 获取单位信息
-(NSArray *)getDeptForOrg:(NSString *)orgid;//根据id 获取 部门信息 
-(NSArray *)getDeptForDept:(NSString *)deptid;//根据id 获取部门信息
-(NSArray *)searchMemberForKey:(NSString *)key;//根据关键字查询

@end
