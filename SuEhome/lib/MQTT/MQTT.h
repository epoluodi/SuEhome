//
//  MQTT.h
//  SuEhome
//
//  Created by Stereo on 2016/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQTTConfig.h"

@interface MQTT : NSObject
{
    MQTTConfig *_mqqconfig;
}




+(instancetype)getInstance;
-(MQTTConfig *)getMQTTConfig;

@end
