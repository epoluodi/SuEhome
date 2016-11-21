//
//  HttpScore.m
//  SuEhome
//
//  Created by Stereo on 2016/11/21.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "HttpScore.h"

@implementation HttpScore


-(ReturnData *)queryDailyScore
{
    _http.WebServiceUrl = statisticsDailyTasks;
    
    NSData * ret =  [_http httprequest:nil];
    
    ReturnData *rd = [ReturnData getReturnDatawithData:ret dataMode:YES];

    NSLog(@"用户积分 %@", rd.returnData);
    
    return  rd;

}
@end
