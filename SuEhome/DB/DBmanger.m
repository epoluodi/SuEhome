//
//  DBmanger.m
//  DyingWish
//
//  Created by xiaoguang yang on 15-4-2.
//  Copyright (c) 2015年 Apollo. All rights reserved.
//

#import "DBmanger.h"
#import <Common/FileCommon.h>
#import "UserInfo.h"



@implementation DBmanger


static DBmanger *_db;


+(instancetype)getIntance
{
    if (!_db)
        _db = [[DBmanger alloc] initDB];
    return _db;
}

-(instancetype)initDB
{
    
    self = [super init];
    
    mangedcontext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    mangedcontext.persistentStoreCoordinator = [self persistentstorecoordinator];
    
    return self;
}

-(NSPersistentStoreCoordinator*)persistentstorecoordinator
{
    NSString * modelpath = [[NSBundle mainBundle] pathForResource:@"db" ofType:@"momd"];
    mangedobjectmodel = [[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL fileURLWithPath:modelpath]];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mangedobjectmodel];
    NSString *docs = [FileCommon getCacheDirectory];
    
    
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"Main.db"]];//要存得数据文件名
    
    
    
    NSError *error = nil;
    NSPersistentStore *store = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
        
        
        
        return nil;
    }
    return persistentStoreCoordinator;
    
}




//
////插入部门数据
//-(void)addDepartment:(NSString *)name departmentid:(NSString *)departmentid
//{
//    Department *dp = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:mangedcontext];
//    
//    [dp setValue:name forKey:@"name"];
//    [dp setValue:departmentid forKey:@"departmentid"];
//    [mangedcontext save:nil];
//
//}
//
//
////删除部门
//-(void)deletDepartment
//{
//    
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Department"];
//    
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    for (Department *obj in arr)
//    {
//        [mangedcontext deleteObject:obj];
//    }
//    [mangedcontext save:nil];
//    return ;
//}
//
//
//
//


#pragma mark 亲情好友

//添加用户信息
-(void)addFriendList:(NSDictionary *)frienddict
{
    T_friendlist * _tfriendlist = [NSEntityDescription insertNewObjectForEntityForName:@"T_friendlist" inManagedObjectContext:mangedcontext];
    
    [_tfriendlist setValue:[frienddict objectForKey:@"userId"] forKey:@"userid"];
    [_tfriendlist setValue:[frienddict objectForKey:@"picId"] forKey:@"picid"];
    [_tfriendlist setValue:[frienddict objectForKey:@"nickName"] forKey:@"nickname"];
    
    if ([[frienddict objectForKey:@"nickName"] isEqualToString:@"1"])
        [_tfriendlist setValue:@1 forKey:@"gender"];
    else
        [_tfriendlist setValue:@2 forKey:@"gender"];
    
//    [_tfriendlist setValue:[frienddict objectForKey:@"areaName"] forKey:@"nameremark"];
    
    
    [_tfriendlist setValue:[frienddict objectForKey:@"pinyin"] forKey:@"py"];
    
    
    NSString *_s =[frienddict objectForKey:@"firstLetter"] ;
    int chatacsii = [_s characterAtIndex:0];
    if (chatacsii > 64 && chatacsii < 91)
        [_tfriendlist setValue:[frienddict objectForKey:@"firstLetter"] forKey:@"fpy"];
    else
        [_tfriendlist setValue:[frienddict objectForKey:@"@"] forKey:@"fpy"];
    
    [mangedcontext save:nil];
}

-(void)deleAllFriendList
{
    
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_friendlist"];
    
    //排序
    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
    //    fetch.sortDescriptors=@[sort];
    //加入查询条件 age>20
    //    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
    
    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    for (T_friendlist *obj in arr)
    {
        [mangedcontext deleteObject:obj];
    }
    [mangedcontext save:nil];
    return ;
}


//获得用户朋友列表 pingying 分组
-(NSArray *)getFiendlistGroupCoountForPingYing
{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_friendlist"];
    fetch.propertiesToGroupBy = @[@"fpy"];
    fetch.propertiesToFetch = @[@"fpy"];
    fetch.resultType=NSDictionaryResultType ;
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    NSLog(@"%@",arr);
    return arr;
    
}

-(NSArray *)getFiendListAllForPY:(NSString *)fpy
{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_friendlist"];    
//    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"msgdate" ascending:YES];
//    fetch.sortDescriptors=@[sort];
    //加入查询条件 age>20
    fetch.predicate=[NSPredicate predicateWithFormat:@"fpy=%@",fpy];
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    return arr;
    
}

#pragma mark -



#pragma mark 企业通讯录


-(void)deletAllOrg
{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_ORG"];
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    for (T_ORG *obj in arr)
    {
        [mangedcontext deleteObject:obj];
    }
    [mangedcontext save:nil];
    return ;
}




//添加组织信息
-(void)addORG:(NSDictionary *)orgdict
{
    T_ORG * _torg = [NSEntityDescription insertNewObjectForEntityForName:@"T_ORG" inManagedObjectContext:mangedcontext];
    
    [_torg setValue:[orgdict objectForKey:@"orgId"] forKey:@"org_id"];
    [_torg setValue:[orgdict objectForKey:@"orgName"] forKey:@"org_name"];
    [_torg setValue:[orgdict objectForKey:@"pOrgId"] forKey:@"p_org_id"];
    [_torg setValue:[orgdict objectForKey:@"dispSn"] forKey:@"disp_sn"];
    
     [_torg setValue:[STCommon PingYingTran:[orgdict objectForKey:@"orgName"]] forKey:@"py"];
    
    [mangedcontext save:nil];
}



-(void)deletAllDept
{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_DEPT"];
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    for (T_DEPT *obj in arr)
    {
        [mangedcontext deleteObject:obj];
    }
    [mangedcontext save:nil];
    return ;
}



//添加组织信息
-(void)addDEPT:(NSDictionary *)deptdict
{
    T_DEPT * _tdept = [NSEntityDescription insertNewObjectForEntityForName:@"T_DEPT" inManagedObjectContext:mangedcontext];
    
    [_tdept setValue:[deptdict objectForKey:@"deptId"] forKey:@"dept_id"];
    [_tdept setValue:[deptdict objectForKey:@"deptName"] forKey:@"dept_name"];
    [_tdept setValue:[deptdict objectForKey:@"pDeptId"] forKey:@"p_dept_id"];
    [_tdept setValue:[deptdict objectForKey:@"dispSn"] forKey:@"disp_sn"];
    
    [_tdept setValue:[deptdict objectForKey:@"dispSn"] forKey:@"disp_sn"];
    [_tdept setValue:[deptdict objectForKey:@"orgId"] forKey:@"org_id"];

    [_tdept setValue:[STCommon PingYingTran:[deptdict objectForKey:@"deptName"]] forKey:@"py"];
    
    [mangedcontext save:nil];
}



-(void)deletAllMember
{

    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_Member"];
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    for (T_Member *obj in arr)
    {
        [mangedcontext deleteObject:obj];
    }
    [mangedcontext save:nil];
    return ;
}



//添加组织信息
-(void)addMember:(NSDictionary *)memberdict
{
    T_Member * _tmember = [NSEntityDescription insertNewObjectForEntityForName:@"T_Member" inManagedObjectContext:mangedcontext];
    
    [_tmember setValue:[memberdict objectForKey:@"deptId"] forKey:@"dept_id"];
    if ([[memberdict objectForKey:@"gender"]   isEqualToString:@"2"])
        [_tmember setValue:@2 forKey:@"gender"];
    else
         [_tmember setValue:@1 forKey:@"gender"];
    [_tmember setValue:[memberdict objectForKey:@"name"] forKey:@"nick_name"];
    [_tmember setValue:[memberdict objectForKey:@"userName"] forKey:@"user_name"];
    [_tmember setValue:[memberdict objectForKey:@"phone"] forKey:@"phone"];
    [_tmember setValue:[memberdict objectForKey:@"orgId"] forKey:@"org_id"];
    [_tmember setValue:[memberdict objectForKey:@"userId"] forKey:@"user_id"];
    [_tmember setValue:[STCommon PingYingTran:[memberdict objectForKey:@"deptName"]] forKey:@"py"];
    [_tmember setValue:[[STCommon PingYingTran:[memberdict objectForKey:@"deptName"]] substringFromIndex:1] forKey:@"fpy"];
    
    [mangedcontext save:nil];
}


-(NSArray *)getMembersForDept:(NSString *)deptid
{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_Member"];
    fetch.predicate=[NSPredicate predicateWithFormat:@"dept_id=%@",deptid];
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    return arr;
    
}

-(NSString *)getOrgName:(NSString *)orgid
{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_ORG"];
    fetch.predicate=[NSPredicate predicateWithFormat:@"org_id=%@",orgid];
    fetch.propertiesToFetch = @[@"org_name"];
    fetch.resultType=NSDictionaryResultType ;
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    NSLog(@"%@",arr);
    if (arr){
        NSDictionary *d = arr[0];
        return [d objectForKey:@"org_name"];
    }
    return nil;
}


-(NSString *)getDeptName:(NSString *)deptid
{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_DEPT"];
    fetch.predicate=[NSPredicate predicateWithFormat:@"dept_id=%@",deptid];
    fetch.propertiesToFetch = @[@"dept_name"];
    fetch.resultType=NSDictionaryResultType ;
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    NSLog(@"%@",arr);
    if (arr)
    {
        NSDictionary *d = arr[0];
        return [d objectForKey:@"dept_name"];
    }
    return nil;
}


-(NSDictionary *)getMainOrgInfo:(NSString *)orgid orgName:(NSString *)orgname
{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"T_ORG"];
    fetch.predicate=[NSPredicate predicateWithFormat:@"p_org_id=%@",@""];
    fetch.propertiesToFetch = @[@"org_id",@"org_name"];
    fetch.resultType=NSDictionaryResultType ;
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    NSLog(@"%@",arr);
    if (arr)
    {
        NSDictionary *d = arr[0];
        return d;
    }
  
    return nil;
}
#pragma mark -



//
//
//
//
////添加调度信息
//-(void)addJDinfo:(NSDictionary *)jdinfo
//{
//    DDInfo *ddinfo = [NSEntityDescription insertNewObjectForEntityForName:@"DDInfo" inManagedObjectContext:mangedcontext];
//    [ddinfo setValue:[jdinfo objectForKey:@"DISPATCH_ID"] forKey:@"ddid"];
//    [ddinfo setValue:jdinfo.description forKey:@"json"];
//    [ddinfo setValue:[jdinfo objectForKey:@"DISPATCH_TITLE"] forKey:@"title"];
//
//    NSNumber *_istop = [[NSNumber alloc] initWithInt:((NSString *)[jdinfo objectForKey:@""]).intValue];
//    [ddinfo setValue:_istop forKey:@"istop"];
//    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date = [formater dateFromString:[jdinfo objectForKey:@"SEND_TIME"]];
//    [ddinfo setValue:date forKey:@"sendtime"];
//    
//    [mangedcontext save:nil];
//}
//
////保存聊天信息
//-(ChatLog *)addChatLog:(NSDictionary *)chatdata
//{
//    ChatLog *chatlog = [NSEntityDescription insertNewObjectForEntityForName:@"ChatLog" inManagedObjectContext:mangedcontext];
//    
//    
//    [chatlog setValue:[chatdata objectForKey:@"receiverDispatchId"] forKey:@"groupid"];
//    [chatlog setValue:[chatdata objectForKey:@"receiverDispatchId"] forKey:@"msgid"];
//    NSDictionary *msgbody =[chatdata objectForKey:@"msgBody"];
//    NSNumber *msgtype;
//    if ([[msgbody objectForKey:@"msgType"] isEqualToString:@"01"])
//        msgtype = @1;
//    else    if ([[msgbody objectForKey:@"msgType"] isEqualToString:@"02"])
//        msgtype = @2;
//    else    if ([[msgbody objectForKey:@"msgType"] isEqualToString:@"03"])
//        msgtype = @3;
//    [chatlog setValue:msgtype forKey:@"msgType"];
//    [chatlog setValue:[msgbody objectForKey:@"content"] forKey:@"content"];
//    if ([[chatdata objectForKey:@"sendAccountId"] isEqualToString:[UserInfo getInstance].userId])
//        [chatlog setValue:@2 forKey:@"isself"];
//    else
//        [chatlog setValue:@1 forKey:@"isself"];
//    [chatlog setValue:[chatdata objectForKey:@"sendUserName"] forKey:@"sender"];
//    [chatlog setValue:[chatdata objectForKey:@"sendAccountId"] forKey:@"senderid"];
//    [chatlog setValue:@1 forKey:@"msgsendstate"];
//    [chatlog setValue:[chatdata objectForKey:@"sendTime"] forKey:@"msgdate"];
//    
//    [mangedcontext save:nil];
//    return chatlog;
//}
//
//
////获得部门信息
//-(NSArray *)getChatLog:(NSString *)groupid
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"ChatLog"];
//    
//    //排序
//    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"msgdate" ascending:YES];
//    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"groupid=%@",groupid];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    
//    return arr;
//}
//
//
//


//
//
//
//-(void)deletejdinfo
//{
//    
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"DDInfo"];
//    
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    for (Contacts *obj in arr)
//    {
//        [mangedcontext deleteObject:obj];
//    }
//    [mangedcontext save:nil];
//    return ;
//}
//
//
//
//
//
//
//
////获得部门信息
//-(NSArray *)getDeparment
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Department"];
//
//    //排序
//        NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//        fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
////    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
//
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//
//    return arr;
//}
//
//
//
//-(NSArray *)getContactswithDepartment:(NSString *)dpid
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Contacts"];
//    
//   
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"groupid CONTAINS %@",dpid];
//    
////        fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    
//    return arr;
//}
//
//-(NSArray *)getContactForSearch:(NSString *)key
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Contacts"];
//    
//    
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"name CONTAINS %@ or py  CONTAINS %@",key,key];
//  
//    //        fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    
//    return arr;
//}
//
//-(NSArray *)getContactswithPY:(NSString *)PY
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Contacts"];
//    
//    
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"firstLetter = %@",PY];
//    
//    //        fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    
//    return arr;
//}
//
//
//-(Contacts *)getContactswithuserId:(NSString *)userid
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Contacts"];
//    
//    
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"userid = %@",userid];
//    
//    //        fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    if ([arr count]==0)
//        return nil;
//    return (Contacts *)arr[0];
//}
//
//
//
////得到所有联系人拼音
//-(NSArray *)getfirstlatter
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Contacts"];
//    fetch.propertiesToGroupBy = @[@"firstLetter"];
//    fetch.propertiesToFetch = @[@"firstLetter"];
//    fetch.resultType=NSDictionaryResultType ;
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//
//    return arr;
//    
//}
//
//
////得到调度信息数据
//-(NSArray *)getDDinfo
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"DDInfo"];
//    
//    //排序
//    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"sendtime" ascending:NO];
//    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    
//    return arr;
//}



//
//
//-(int)finddata:(NSString *)stockcode{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Stock"];
//
//    //排序
////    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
////    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//        fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
//
////    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    int l = (int)arr.count;
//    NSLog(@"找到的数据： %d",l);
//    return l;
//}
//
//
//
//
//
//-(int)getDingDongs{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"StockDD"];
//
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
////    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
//
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    int l = (int)arr.count;
//    NSLog(@"叮咚总数： %d",l);
//    return l;
//}
//
//
//
//-(void)updateDingDongs:(NSString *)stockcodeEx l1:(NSString *)l1 l2:(NSString*)l2{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"StockDD"];
//
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//        fetch.predicate=[NSPredicate predicateWithFormat:@"stockcodeEx=%@",stockcodeEx];
//
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    StockDD * sdd;
//    if ([arr count] == 0)
//    {
//        sdd = [NSEntityDescription insertNewObjectForEntityForName:@"StockDD" inManagedObjectContext:mangedcontext];
//
//        [sdd setValue:stockcodeEx forKey:@"stockcodeEx"];
//        [sdd setValue:l1 forKey:@"l1"];
//        [sdd setValue:l2 forKey:@"l2"];
//
//    }
//    else
//    {
//        sdd= [arr objectAtIndex:0];
//        sdd.l1 = l1;
//        sdd.l2=l2;
//
//    }
//    [mangedcontext save:nil];
//    return ;
//}
//
//
//
//
//-(NSArray *)finddatadingdong:(NSString *)stockcodeEx
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"StockDD"];
//
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcodeEx=%@",stockcodeEx];
//
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//
//    return arr;
//}
//

//
//
//
//-(void)deletestockDD:(NSString *)stockcodeEx
//{
//
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"StockDD"];
//
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcodeEx=%@",stockcodeEx];
//
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    for (Stock *obj in arr)
//    {
//        [mangedcontext deleteObject:obj];
//    }
//    [mangedcontext save:nil];
//    return ;
//}
//
//-(void)deletestockDD
//{
//
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"StockDD"];
//
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
////    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcodeEx=%@",stockcodeEx];
//
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    for (Stock *obj in arr)
//    {
//        [mangedcontext deleteObject:obj];
//    }
//    [mangedcontext save:nil];
//    return ;
//}
//
//
//-(void)deletestock
//{
//
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Stock"];
//
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcodeEx=%@",stockcodeEx];
//
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    for (Stock *obj in arr)
//    {
//        [mangedcontext deleteObject:obj];
//    }
//    [mangedcontext save:nil];
//    return ;
//}


@end

