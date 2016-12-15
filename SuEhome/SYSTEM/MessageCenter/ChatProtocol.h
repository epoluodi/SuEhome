//
//  ChatProtocol.h
//  SuEhome
//
//  Created by Stereo on 2016/12/14.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseProtocol.h"
#import "ChatMessage.h"



@interface ChatProtocol : BaseProtocol
{
   
}




@property (weak,nonatomic)NSString * ope;                       //聊天类型
@property (weak,nonatomic)NSString * from;                      //来自
@property (weak,nonatomic)NSString * to;                        //发送目标
@property (assign) MessageEnum messageEnum;                 //消息类型
@property (assign)int Int_messageType;                          //消息类型int
@property (weak,nonatomic)NSString * atuser;                //at一个用户
@property (weak,nonatomic) NSDictionary *body;              //消息内容
@property (weak,nonatomic) NSDictionary *mainjson;     //消息主体
@property (weak,nonatomic)NSNumber * sendtime;          //发送时间
@property (weak,nonatomic)NSString * msgid;              // 消息ID
@property (assign) BOOL noDisturb;                              //是否免打扰
@property (assign) BOOL istop;                                 //是否置顶

@end
