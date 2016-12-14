//
//  MQTT.m
//  SuEhome
//
//  Created by Stereo on 2016/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MQTT.h"
#import "AppCommon.h"

@implementation MQTT
@synthesize IsMQTTConnect;

static MQTT *_mqtt;


-(instancetype)init
{
    self = [super init];
    IsMQTTConnect = NO;
    
    NSDictionary *d = [[NSDictionary alloc] initWithObjectsAndKeys:[[AppInfo getInstance] getUserInfo].userId ,@"userId", nil];
    NSData *json = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
    linemessage =  [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    return self;
}
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


-(void)ConnectMQTT
{
 
    NSLog(@"MQTT 连接信息 \n 服务地址:%@\n 服务端口：%@ \n 用户名：%@\n 密码:%@",
          _mqqconfig.mqttServer,_mqqconfig.mqttPort,_mqqconfig.mqttUserName,_mqqconfig.mqttUserPwd);
    
    mqttclient = [[MQTTClient alloc] initWithClientId:[UIDevice currentDevice].identifierForVendor.UUIDString cleanSession:YES];
    mqttclient.host=_mqqconfig.mqttServer;
    mqttclient.port=[_mqqconfig.mqttPort intValue];
    [self setMessage];
    [self DisConntectEvent];
    [mqttclient setWill:linemessage toTopic:offlineTopic withQos:ExactlyOnce retain:NO];
    
    [mqttclient connectWithCompletionHandler:_mqqconfig.mqttUserName andPassword:_mqqconfig.mqttUserPwd andCallBack:^(MQTTConnectionReturnCode code) {
        if (code==0)
        {
            NSLog(@"MQTT 连接成功");
            IsMQTTConnect = YES;
            
            [mqttclient publishString:linemessage  toTopic:onlineTopic withQos:ExactlyOnce retain:NO completionHandler:^(int mid) {
                NSLog(@"MQTT 连接发送在线信息状态--> %d",mid);
            }];
            [_mqtt PublishGroupTopic:_mqqconfig.ChatNoice];
            [_mqtt PublishGroupTopic:_mqqconfig.SystemNoice];
            [ _mqtt->_delegate OnConnectMqtt];
        }
        else
        {
            NSLog(@"MQTT 连接失败");
            IsMQTTConnect = NO;
            [ _mqtt->_delegate OnConnectError];
        }
    }];
}





//MQTT断开
-(void)DisConnectMQTT
{
    BACK(^{
        [mqttclient publishString:linemessage toTopic:offlineTopic withQos:ExactlyOnce retain:NO completionHandler:^(int mid) {
            NSLog(@"MQTT 连接发送离线信息状态--> %d",mid);
        }];
        sleep(1);
        [mqttclient disconnectWithCompletionHandler:nil];
        IsMQTTConnect = NO;
    });
 
}
//设置断开监听
-(void)DisConntectEvent
{
    [mqttclient setDisconnectionHandler:^(NSUInteger code){
        NSLog(@"断开mqtt %lu",(unsigned long)code);
        IsMQTTConnect=NO;
        [ _mqtt->_delegate OnDisConnect];
    }];
}


//订阅
-(void)PublishGroupTopic:(NSString *)topic
{
    [mqttclient subscribe:topic withQos:AtMostOnce completionHandler:^(NSArray *grantedQos) {
        NSLog(@"订阅结果 %@",grantedQos);
    }];
}


//发送消息
-(void)sendMessage:(NSString *)topic content:(NSString *)content
{
    [mqttclient publishString:content toTopic:topic withQos:ExactlyOnce retain:NO completionHandler:nil];
}

//设置接收消息回调
-(void)setMessage
{
    
    [mqttclient setMessageHandler:^(MQTTMessage* message)
     {
         dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
         dispatch_async(globalQ, ^{
             //接收到消息，更新界面时需要切换回主线程
             [_mqtt->_delegate OnMessage:[message payloadString] topic:message.topic];
         });
     }];
}


@end
