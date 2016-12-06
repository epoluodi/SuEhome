//
//  Emj.m
//  SuEhome
//
//  Created by Stereo on 2016/12/6.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "Emj.h"

static Emj *_emj;
@implementation Emj


+(instancetype)getEmj
{
    if (!_emj)
        _emj = [[Emj alloc] init];
    return _emj;
}




-(instancetype)init
{
    self = [super init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"json"];
    NSData *emjdata = [NSData dataWithContentsOfFile:filePath];
    

    emojijson = [NSJSONSerialization JSONObjectWithData:emjdata options:NSJSONReadingMutableContainers error:nil];
    return self;
}

-(NSInteger)getCount
{
    return emojijson.count;
}

-(NSDictionary *)getEmjKeyAndValue:(int)index
{
    return  ((NSDictionary *)emojijson[index]);
}

-(NSData *)getEmjData:(NSString *)emjstring
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:emjstring ofType:@"png"];
    NSData *emjdata = [NSData dataWithContentsOfFile:filePath];
    return emjdata;
}

-(NSData *)getEmjDataForIndex:(int)index
{
    NSDictionary *d = [self getEmjKeyAndValue:index];
    NSData *emjdata = [self getEmjData:[d objectForKey:@"emojifile"]];
    return emjdata;
}


+(NSAttributedString *)getAttrString:(NSString *)string addimg:(UIImage *)img
{
    NSMutableAttributedString * mutStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSTextAttachment * attachment1 = [[NSTextAttachment alloc] init];
    attachment1.bounds = CGRectMake(0, 0, 22, 22);
    attachment1.image = img;
    NSAttributedString * attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];

    
    NSLog(@"文字 %@",string);
        NSLog(@"文字 %@",[mutStr string]);
    [mutStr insertAttributedString:attachStr1 atIndex:mutStr.length];
    [mutStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:18.0]
                   range:NSMakeRange(0, mutStr.length)];
    return mutStr;
}

@end
