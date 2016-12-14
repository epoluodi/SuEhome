//
//  BaseProtocol.m
//  SuEhome
//
//  Created by Stereo on 2016/12/14.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseProtocol.h"

@implementation BaseProtocol
@synthesize Mode;



-(instancetype)init:(NSString *)json
{
    self = [super init];
    
    NSData *jsondata = [json dataUsingEncoding:NSUTF8StringEncoding];
    
     _dictjson = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:nil];
    
    return self;
}

@end
