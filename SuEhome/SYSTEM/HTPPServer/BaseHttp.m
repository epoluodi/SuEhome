//
//  BaseHttp.m
//  SuEhome
//
//  Created by Stereo on 2016/11/4.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseHttp.h"
#import "AppCommon.h"
@implementation BaseHttp


-(instancetype)init
{
    self = [super init];
    _http = [[HttpClass alloc] init];
    [_http setIsHead:YES];
    if ([[AppInfo getInstance] getAppRunInfo]->TOEKN != NULL)
        [_http addHeadString:@"token" value:[NSString stringWithUTF8String:[[AppInfo getInstance] getAppRunInfo]->TOEKN] ];
    

    [_http addHeadString:@"deviceID" value:[[UIDevice currentDevice].identifierForVendor UUIDString] ];
    [_http addHeadString:@"deviceType" value:@"1"];
    return self;
}

@end
