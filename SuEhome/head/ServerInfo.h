//
//  ServerInfo.h
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

//#define HOST @"http://suehome.suypower.com/Cloudx"//正式
#define HOST @"http://192.168.0.66:8081/Cloudx" //开发

#define AuthUrl                  [NSString stringWithFormat:@"%@/auth/",HOST]
#define AppUrl                   [NSString stringWithFormat:@"%@/app/",HOST]
#define IMUrl                     [NSString stringWithFormat:@"%@/im/",HOST]
#define APIUrl                    [NSString stringWithFormat:@"%@/api/",HOST]
#define AppUpgradeUrl       [NSString stringWithFormat:@"%@/upgrade/",HOST]
#define ArticleUrl               [NSString stringWithFormat:@"%@/article/",HOST]
#define MobileUrl               [NSString stringWithFormat:@"%@/mobile/",HOST]



#import "HttpClass.h"
#import "ReturnData.h"
