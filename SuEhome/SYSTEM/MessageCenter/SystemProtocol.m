//
//  SystemProtocol.m
//  SuEhome
//
//  Created by Stereo on 2016/12/14.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "SystemProtocol.h"

@implementation SystemProtocol

-(instancetype)init:(NSString *)json
{
    self = [super init:json];
    [self AnalysisJson];
    return  self;
}


//分析json 数据
-(void)AnalysisJson
{
//    from = [self->_dictjson objectForKey:@"from"];
//    to = [self->_dictjson objectForKey:@"to"];
//    ope =[self->_dictjson objectForKey:@"ope"];
//    Int_messageType = [[self->_dictjson objectForKey:@"type"] intValue];
//    switch (Int_messageType) {
//        case 1:
//            messageEnum = TEXT;
//            break;
//        case 2:
//            messageEnum = PHOTO;
//            break;
//        case 3:
//            messageEnum = AUDIO;
//            break;
//    }
//    sendtime = [self->_dictjson objectForKey:@"sendTime"];
//    if ([[self->_dictjson objectForKey:@"noDisturb"] isEqual:@(0)])
//        noDisturb = NO;
//    else
//        noDisturb = YES;
//    
//    if ([[self->_dictjson objectForKey:@"top"] isEqual:@(0)])
//        istop = NO;
//    else
//        istop = YES;
//    
//    msgid = [self->_dictjson objectForKey:@"msgId"];
}



@end
