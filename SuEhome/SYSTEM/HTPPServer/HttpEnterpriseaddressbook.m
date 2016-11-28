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
    
//    [[DBmanger getIntance] deleAllFriendList];
//    for (NSDictionary *d in rd.returnDatas) {
//        [[DBmanger getIntance] addFriendList:d];
//    }
    
    return  rd;
}
@end
