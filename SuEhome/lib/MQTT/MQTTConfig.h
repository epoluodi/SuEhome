//
//  MQTTConfig.h
//  SuEhome
//
//  Created by Stereo on 2016/11/7.
//  Copyright © 2016年 Suypower. All rights reserved.
//


#define    offlineTopic @"topic/offline"
#define    onlineTopic  @"topic/online"
#define    receipMsgTopic @"topic/msgReceipt" //消息回执
#define    receiptNoticeTopic  @"topic/noticeReceipt"//系统消息回执

#import <Foundation/Foundation.h>

@interface MQTTConfig : NSObject



@property (copy,nonatomic)NSString *mqttServer;
@property (copy,nonatomic)NSString *mqttPort;
@property (copy,nonatomic)NSString *mqttUserName;
@property (copy,nonatomic)NSString *mqttUserPwd;

@property (copy,nonatomic)NSString *SystemNoice;
@property (copy,nonatomic)NSString *ChatNoice;


@end
