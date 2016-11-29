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



//企业通讯录
-(void)deletAllOrg;//删除所有组织记录
-(void)addORG:(NSDictionary *)orgdict;//添加组织信息 

-(void)deletAllDept;//删除所有部门信息
-(void)addDEPT:(NSDictionary *)deptdict;//添加部门

-(void)deletAllMember;//删除成员信息
-(void)addMember:(NSDictionary *)memberdict;//添加成员信息

@end
