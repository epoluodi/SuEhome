//
//  Emj.h
//  SuEhome
//
//  Created by Stereo on 2016/12/6.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Emj : NSObject
{
    NSArray *emojijson;
    NSMutableDictionary *emjdict;
}

//获得实例
+(instancetype)getEmj;

//插入一个表情
+(NSAttributedString *)getAttrString:(NSString *)string addimg:(UIImage *)img EmjString:(NSString *)emjstr Range:(NSRange)CurRange;



//获取表情数据字典
-(NSDictionary *)getEmjKeyAndValue:(int)index;
-(NSData *)getEmjData:(NSString *)emjstring;
-(NSData *)getEmjDataForIndex:(int)index;

//获取当前表情数量
-(NSInteger)getCount;
@end
