//
//  HttpLogin.h
//  SuEhome
//
//  Created by Stereo on 2016/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseHttp.h"
#import "MQTT.h"
#import "AppInfo.h"

//登录
#define getToken  [NSString stringWithFormat:@"%@getToken?",AuthUrl]




@interface HttpLogin : BaseHttp


//初始化
-(instancetype)init:(NSString *)username pwd:(NSString *)pwd;


//登录
-(ReturnData *)Login;
@end
