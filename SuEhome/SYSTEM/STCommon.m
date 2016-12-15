//
//  STCommon.m
//  SuEhome
//
//  Created by Stereo on 2016/11/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "STCommon.h"
#import <Common/FileCommon.h>
@implementation STCommon


+(BOOL)CheckFileForcache:(NSString *)mediaId filetype:(NSString *)filetype
{
    NSFileManager *filenamger = [NSFileManager defaultManager];
    NSString *path = [FileCommon getCacheDirectory];
    NSString *filepath =[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",mediaId,filetype]];
    
    return [filenamger fileExistsAtPath:filepath];
}


+(NSString *)PingYingTran:(NSString *)str
{

    if ([str length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:str];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"pinyin: %@", ms);
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"pinyin: %@", ms);
        }
        return [ms stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return nil;
}


+(NSString *)getLongNowDate
{
    return [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970])];
}

+(NSString *)getStringDateTimeForLongDT:(NSString*)longdt
{
    NSDate *dt =  [NSDate dateWithTimeIntervalSince1970:[longdt doubleValue]];
    NSDateFormatter *dtformat = [[NSDateFormatter alloc] init];
    dtformat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dtformat stringFromDate:dt];
}

+(NSDate *)getDateTimeForLongDT:(NSTimeInterval)longdt
{
    NSDate *dt =  [NSDate dateWithTimeIntervalSince1970:longdt /1000];
    return dt;
}





@end
