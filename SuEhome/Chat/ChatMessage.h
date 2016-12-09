//
//  ChatMessage.h
//  SuEhome
//
//  Created by Stereo on 2016/12/9.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBmanger.h"


typedef enum : NSUInteger {
    TEXT                              = 1,
    PHOTO,
    AUDIO,
    EAUDIO,
    SYSTEM                          = 99,//系统
} MessageEnum;

typedef enum : NSUInteger {
    ERROR                   = -1,
    SENDING               =  0,
    SENDFINISH          =  2,
    
} MsgStateEnum;

typedef enum : NSUInteger {
    CHAT,               //单聊
    GROUP,              //群聊
} ChatEnum;

@interface ChatMessage : NSObject

@property (assign) ChatEnum chatEnum;                               //聊天类型
@property (assign)MsgStateEnum msgstateEnum;//消息状态
@property (assign)MessageEnum messageEnum;//消息类型
@property (copy,nonatomic)NSString *groupid;                        //聊天标识
@property (copy,nonatomic)NSString *msgcontent;                 //内容
@property (copy,nonatomic)NSString *msgLongDT;                  //消息时间 long
@property (copy,nonatomic)NSDate *msgdate;
@property (copy,nonatomic)NSString *createmsgLongDT;                  //消息创建时间 long
@property (copy,nonatomic)NSDate *createmsgdate;
@property (assign)BOOL isSelf;                                              //发送消息是否是自己
@property (copy,nonatomic)NSString *senderid;                     //发送者id
@property (copy,nonatomic)NSString *sender;                     //发送人
@property (copy,nonatomic)NSString *msgid;                      //消息id






@end
