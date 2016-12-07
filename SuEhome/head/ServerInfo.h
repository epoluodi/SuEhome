//
//  ServerInfo.h
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

//#define HOST @"http://suehome.suypower.com/Cloudx"//正式
#define HOST @"http://192.168.0.66:8081/Cloudx_dev" //开发
//#define HOST @"http://192.168.0.122:8080/Cloudx" //DK

//#define HOST @"http://om.suypower.com/Cloudx_dev" //开发
#define AuthUrl                  [NSString stringWithFormat:@"%@/auth/",HOST]
#define AppUrl                   [NSString stringWithFormat:@"%@/app/",HOST]
#define IMUrl                     [NSString stringWithFormat:@"%@/im/",HOST]
#define APIUrl                    [NSString stringWithFormat:@"%@/api/",HOST]
#define AppUpgradeUrl       [NSString stringWithFormat:@"%@/upgrade/",HOST]
#define ArticleUrl               [NSString stringWithFormat:@"%@/article/",HOST]
#define MobileUrl               [NSString stringWithFormat:@"%@/mobile/",HOST]


//标签页
#define Tab1Url1                [NSString stringWithFormat:@"%@/html/mobile/home/home.html",HOST]
#define Tab1Url3                [NSString stringWithFormat:@"%@/html/mobile/circle/mycircle.html",HOST]

//亲情
#define FamilyUrl                [NSString stringWithFormat:@"%@/html/mobile/family/index.html",HOST]

//意见反馈
#define FeedbackUrl                [NSString stringWithFormat:@"%@/html/mobile/help/feedBack.html",HOST]



#import "HttpClass.h"
#import "ReturnData.h"
