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


+(NSAttributedString *)getAttrString:(NSString *)string addimg:(UIImage *)img EmjString:(NSString *)emjstr Range:(NSRange)CurRange
{
      NSLog(@"文字 %@",string);
    NSMutableAttributedString * mutStr = [[NSMutableAttributedString alloc] initWithString:string];
    [mutStr insertAttributedString:[[NSMutableAttributedString alloc] initWithString:emjstr] atIndex:CurRange.location];
    
//    NSTextAttachment * attachment1 = [[NSTextAttachment alloc] init];
//    attachment1.bounds = CGRectMake(0, 0, 22, 22);
//    attachment1.image = img;
//    NSAttributedString * attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];

    
  
    NSLog(@"文字 %@",[mutStr string]);
//    [mutStr insertAttributedString:attachStr1 atIndex:mutStr.length];
//    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:NSMakeRange(0, mutStr.length)];
    
    return [Emj tranTextToAttributedString:mutStr.string];
}


//查找字符串中标签占位符
+(NSAttributedString *)tranTextToAttributedString:(NSString *)string
{
    NSMutableAttributedString * mutStr = [[NSMutableAttributedString alloc] initWithString:string];
    
//    Emj *emj= [[Emj alloc] init];
//    
//    NSError *error = NULL;
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[\\!\\w*\\!\\]" options:NSRegularExpressionCaseInsensitive error:&error];
//    NSArray *result = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
//    for (NSTextCheckingResult* regresult in result) {
//        NSLog(@"%@\n", [string substringWithRange:regresult.range]);
//        NSString *emjfilename =[[string substringWithRange:regresult.range] substringWithRange:NSMakeRange(2, [string substringWithRange:regresult.range].length-4)];
//        NSLog(@"%@\n", emjfilename);
//        NSData *emjdata = [emj getEmjData:emjfilename];
//        NSTextAttachment * attachment1 = [[NSTextAttachment alloc] init];
//        attachment1.bounds = CGRectMake(0, 0, 22, 22);
//        attachment1.image = [UIImage imageWithData:emjdata];
//        NSAttributedString * attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
//        [mutStr replaceCharactersInRange:regresult.range withAttributedString:attachStr1];
//    }
    
  
    
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:NSMakeRange(0, mutStr.length)];
    
    return mutStr;
}

@end
