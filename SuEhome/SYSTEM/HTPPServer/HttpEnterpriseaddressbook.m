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
    if ( [USER_DEFAULT integerForKey:@"orgver"] != -1 )
        [_http addParamsString:@"numVer" values:[NSString stringWithFormat:@"%ld", [USER_DEFAULT integerForKey:@"orgver"] ]];
    NSData * ret =  [_http httprequest:[_http getDataForArrary] ];
    
    NSLog(@"返回数据 %@",[[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding]);
    ReturnData *rd = [ReturnData getReturnDatawithData:ret dataMode:YES];

    NSLog(@"获取企业通讯录组织信息 %@",     rd.returnData);
    
    if (![[rd.returnData objectForKey:@"lastNumVer"] isEqual:@([USER_DEFAULT integerForKey:@"orgver"])])
    {
        [[DBmanger getIntance] deletAllOrg];
        NSArray *arr = [rd.returnData objectForKey:@"orgs"];
        for (NSDictionary *d in arr) {
            [[DBmanger getIntance] addORG:d];
        }
        [USER_DEFAULT setInteger:[[rd.returnData objectForKey:@"lastNumVer"] intValue] forKey:@"orgver"];
    }
    return  rd;
}

-(ReturnData *)queryDept
{
    _http.WebServiceUrl = DEPTQUERYURL;
    if ( [USER_DEFAULT integerForKey:@"deptver"] != -1 )
        [_http addParamsString:@"numVer" values:[NSString stringWithFormat:@"%ld", [USER_DEFAULT integerForKey:@"deptver"] ]];
    NSData * ret =  [_http httprequest:[_http getDataForArrary] ];
    ReturnData *rd = [ReturnData getReturnDatawithData:ret dataMode:YES];
    
    NSLog(@"获取企业通讯录部门信息 %@", rd.returnData);
    
        if (![[rd.returnData objectForKey:@"lastNumVer"] isEqual:@([USER_DEFAULT integerForKey:@"deptver"])])
        {
            [[DBmanger getIntance] deletAllDept];
            NSArray *arr = [rd.returnData objectForKey:@"depts"];
            for (NSDictionary *d in arr) {
                [[DBmanger getIntance] addDEPT:d];
            }
            
            [USER_DEFAULT setInteger:[[rd.returnData objectForKey:@"lastNumVer"] intValue] forKey:@"deptver"];
        }

    
    return  rd;
}


-(ReturnData *)queryMember
{
    _http.WebServiceUrl = MEMBERQUERYURL;
    if ( [USER_DEFAULT integerForKey:@"deptver"] != -1 )
        [_http addParamsString:@"numVer" values:[NSString stringWithFormat:@"%ld", [USER_DEFAULT integerForKey:@"userver"] ]];
    NSData * ret =  [_http httprequest:[_http getDataForArrary] ];
    
    ReturnData *rd = [ReturnData getReturnDatawithData:ret dataMode:YES];
    
    NSLog(@"获取企业通讯录成员信息 %@", rd.returnData);
    if (![[rd.returnData objectForKey:@"lastNumVer"] isEqual:@([USER_DEFAULT integerForKey:@"userver"])])
    {
        [[DBmanger getIntance] deletAllMember];
        NSArray *arr = [rd.returnData objectForKey:@"users"];
        for (NSDictionary *d in arr) {
            [[DBmanger getIntance] addMember:d];
        }
        [USER_DEFAULT setInteger:[[rd.returnData objectForKey:@"lastNumVer"] intValue] forKey:@"userver"];
    }

    
    return  rd;
}



@end
