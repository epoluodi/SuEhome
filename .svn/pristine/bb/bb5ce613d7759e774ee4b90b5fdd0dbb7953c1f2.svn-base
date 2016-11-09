//
//  HttpUserInfo.m
//  SuEhome
//
//  Created by 程嘉雯 on 16/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "HttpUserInfo.h"
#import "DBmanger.h"
#import "HttpFile.h"
#import "AppCommon.h"

@implementation HttpUserInfo

-(ReturnData *)getBaseUserInfo
{
    _http.WebServiceUrl = getperson;
    [_http addParamsString:@"userId" values:[[AppInfo getInstance]getUserInfo ].userId];
    NSData * ret =  [_http httprequest:[_http getDataForArrary]];
    
    ReturnData *rd = [ReturnData getReturnDatawithData:ret dataMode:YES];

    NSLog(@"用户基本信息 %@", rd.returnData);
    NSDictionary *d = rd.returnData;
    [[AppInfo getInstance] getUserInfo].nickName =      [d objectForKey:@"nickname"];
    [[AppInfo getInstance] getUserInfo].realName =      [d objectForKey:@"name"];
    [[AppInfo getInstance] getUserInfo].photo =         [d objectForKey:@"picId"];
    [[AppInfo getInstance] getUserInfo].photoUrl =      [d objectForKey:@"picPath"];
    [[AppInfo getInstance] getUserInfo].score =         [d objectForKey:@"score"];
    [[AppInfo getInstance] getUserInfo].mobile =        [d objectForKey:@"phone"];
    [[AppInfo getInstance] getUserInfo].email =         [d objectForKey:@"email"];
    
    if ([[d objectForKey:@"gender"] isEqualToString:@"1"])
        [[AppInfo getInstance] getUserInfo].sex =       MALE;
    else
        [[AppInfo getInstance] getUserInfo].sex =       FEMALE;
    
    if ([[d objectForKey:@"userType"] isEqualToString:@"1"])
        [[AppInfo getInstance] getUserInfo].userType =       WORKER;
    else
        [[AppInfo getInstance] getUserInfo].userType =       OLDMAN;

    [[AppInfo getInstance] getUserInfo].addr =         [d objectForKey:@"detailAddr"];
    [[AppInfo getInstance] getUserInfo].departName =         [d objectForKey:@"deptName"];
    [[AppInfo getInstance] getUserInfo].departId =         [d objectForKey:@"deptId"];
    
    [[AppInfo getInstance] getUserInfo].orgName =         [d objectForKey:@"orgName"];
    [[AppInfo getInstance] getUserInfo].orgId =         [d objectForKey:@"orgId"];
    
    
    if (![STCommon CheckFileForcache:[[AppInfo getInstance] getUserInfo].photo filetype:@".jpg"]){
        BACK(^{
            HttpFile *httpfile = [[HttpFile alloc] init:JPG];
            [httpfile downloadFile:[[AppInfo getInstance] getUserInfo].photo fileSize:@"_120"];
        });
        BACK(^{
            
            HttpFile *httpfile = [[HttpFile alloc] init:JPG];
            [httpfile downloadFile:[[AppInfo getInstance] getUserInfo].photo fileSize:@"_40"];
        });
        BACK(^{
            
            HttpFile *httpfile = [[HttpFile alloc] init:JPG];
            [httpfile downloadFile:[[AppInfo getInstance] getUserInfo].photo fileSize:@""];
        });
    
    }
    return  rd;
}


-(ReturnData *)getFamilyList{
    _http.WebServiceUrl = getfamilylist;

    NSData * ret =  [_http httprequest:nil];
    
    ReturnData *rd = [ReturnData getReturnDatawithData:ret dataMode:NO];

    NSLog(@"用户亲情好友 %@", rd.returnDatas);
    
    [[DBmanger getIntance] deleAllFriendList];
    for (NSDictionary *d in rd.returnDatas) {
        [[DBmanger getIntance] addFriendList:d];
    }
 
    return  rd;

}
@end
