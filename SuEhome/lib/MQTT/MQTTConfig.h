//
//  MQTTConfig.h
//  SuEhome
//
//  Created by Stereo on 2016/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTTConfig : NSObject



@property (copy,nonatomic)NSString *mqttServer;
@property (copy,nonatomic)NSString *mqttPort;
@property (copy,nonatomic)NSString *mqttUserName;
@property (copy,nonatomic)NSString *mqttUserPwd;

@property (copy,nonatomic)NSString *SystemNoice;
@property (copy,nonatomic)NSString *ChatNoice;


@end
