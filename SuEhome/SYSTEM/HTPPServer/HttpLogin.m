//
//  HttpLogin.m
//  SuEhome
//
//  Created by Stereo on 2016/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "HttpLogin.h"



@implementation HttpLogin


-(instancetype)init:(NSString *)username pwd:(NSString *)pwd
{
    self  = [super init];
    _weburl = [NSString stringWithFormat:@"%@username=%@&password=%@",getToken, username,pwd];
    
    return self;
}


-(ReturnData *)Login
{
    
    _http.WebServiceUrl = _weburl;

    NSString * ret =  [_http httprequestForGet:_http.WebServiceUrl];
    ReturnData *rd = [ReturnData getReturnData:ret dataMode:YES];
    NSLog(@"登录返回 %@",ret);
    if (rd.returnCode == 0  )
    {
        
        NSDictionary *d = rd.returnData;
        MQTTConfig *mqttconfig = [[MQTT getInstance] getMQTTConfig];
        
        mqttconfig.mqttServer = [[d objectForKey:@"MQTT"] objectForKey:@"mqttip"];
        mqttconfig.mqttPort = [[d objectForKey:@"MQTT"] objectForKey:@"mqttport"];
        mqttconfig.mqttUserName = [[d objectForKey:@"MQTT"] objectForKey:@"username"];
        mqttconfig.mqttUserPwd = [[d objectForKey:@"MQTT"] objectForKey:@"password"];
        
        [AppInfo getInstance].getUserInfo.userId =[d objectForKey:@"userId"];
        
        mqttconfig.ChatNoice = [NSString stringWithFormat:@"topic/chat/%@",[AppInfo getInstance].getUserInfo.userId ];
        mqttconfig.SystemNoice = [NSString stringWithFormat:@"topic/notice/%@",[AppInfo getInstance].getUserInfo.userId ];
        
        
        if (     [[AppInfo getInstance] getAppRunInfo]->TOEKN == NULL)
            free(  (void *)   [[AppInfo getInstance] getAppRunInfo]->TOEKN);
        
        void *mtoken =malloc([[d objectForKey:@"userId"] length]);
        strcpy(mtoken, [[d objectForKey:@"token"] UTF8String ]);
        [[AppInfo getInstance] getAppRunInfo]->TOEKN =mtoken;
        printf("令牌 %s",[[AppInfo getInstance] getAppRunInfo]->TOEKN);
        

        
    }
    
    return rd;
    
}


@end
