//
//  MQTT.m
//  SuEhome
//
//  Created by Stereo on 2016/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MQTT.h"

@implementation MQTT

static MQTT *_mqtt;


+(instancetype)getInstance
{
    if (!_mqtt)
        _mqtt = [[MQTT alloc] init];
    return _mqtt;
}


-(MQTTConfig *)getMQTTConfig
{
    if (!_mqqconfig)
        _mqqconfig = [[MQTTConfig alloc] init];
    return _mqqconfig;
}

@end
