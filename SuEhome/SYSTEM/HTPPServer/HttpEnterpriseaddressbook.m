//
//  HttpEnterpriseaddressbook.m
//  SuEhome
//
//  Created by Stereo on 2016/11/28.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "HttpEnterpriseaddressbook.h"

@implementation HttpEnterpriseaddressbook

-(ReturnData *)queryOrg
{
    _http.WebServiceUrl = ORGQUERYURL;
    
    NSData * ret =  [_http httprequest:nil];
    
    ReturnData *rd = [ReturnData getReturnDatawithData:ret dataMode:NO];
    
    NSLog(@"获取企业通讯录组织信息 %@", rd.returnDatas);
    
    [[DBmanger getIntance] deletAllOrg];
    for (NSDictionary *d in rd.returnDatas) {
        [[DBmanger getIntance] addORG:d];
    }
    
    return  rd;
}

-(ReturnData *)queryDept
{
    _http.WebServiceUrl = DEPTQUERYURL;
    
    NSData * ret =  [_http httprequest:nil];
    
    ReturnData *rd = [ReturnData getReturnDatawithData:ret dataMode:NO];
    
    NSLog(@"获取企业通讯录部门信息 %@", rd.returnDatas);
    
    [[DBmanger getIntance] deletAllDept];
    for (NSDictionary *d in rd.returnDatas) {
        [[DBmanger getIntance] addDEPT:d];
    }
    
    return  rd;
}


-(ReturnData *)queryMember
{
    _http.WebServiceUrl = MEMBERQUERYURL;
    
    NSData * ret =  [_http httprequest:nil];
    
    ReturnData *rd = [ReturnData getReturnDatawithData:ret dataMode:NO];
    
    NSLog(@"获取企业通讯录成员信息 %@", rd.returnDatas);
    
    [[DBmanger getIntance] deletAllMember];
    for (NSDictionary *d in rd.returnDatas) {
        [[DBmanger getIntance] addMember:d];
    }
    
    return  rd;
}



@end
