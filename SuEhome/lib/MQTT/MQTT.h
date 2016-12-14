//
//  MQTT.h
//  SuEhome
//
//  Created by Stereo on 2016/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MQTTConfig.h"
#import "MQTTKit.h"


@protocol MQTTDelegate

//收到信息,根据订阅号收到
-(void)OnMessage:(NSString *)msg topic:(NSString *)topic;



@optional
-(void)OnConnectMqtt; //连接上 mqtt
-(void)OnDisConnect;  //断开连接
-(void)OnConnectError; //连接错误


@end



@interface MQTT : NSObject
{
    MQTTConfig *_mqqconfig;
    MQTTClient *mqttclient;

    NSString *linemessage;
}


@property (assign)BOOL IsMQTTConnect;//当前是否连接MQTT
@property  (nonatomic,weak)  NSObject<MQTTDelegate> *delegate;


+(instancetype)getInstance;


//获得和设置当前MQTT server
-(MQTTConfig *)getMQTTConfig;


-(void)ConnectMQTT;
-(void)DisConnectMQTT;

//订阅
-(void)PublishGroupTopic:(NSString *)topic;
-(void)sendMessage:(NSString *)topic content:(NSString *)content;

@end
