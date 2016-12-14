//
//  BaseProtocol.h
//  SuEhome
//
//  Created by Stereo on 2016/12/14.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseProtocol : NSObject
{
    @public
    NSDictionary *_dictjson;
}

-(instancetype)init:(NSString *)json;

@property (assign)int Mode;
@end
