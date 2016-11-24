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
@end
