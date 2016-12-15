//
//  MessageControll.h
//  SuEhome
//
//  Created by Stereo on 2016/12/14.
//  Copyright © 2016年 Suypower. All rights reserved.
// 消息处理中心

#import <Foundation/Foundation.h>
#import "ChatProtocol.h"
#import "SystemProtocol.h"

@interface MessageControll : NSObject



//处理聊天信息
-(void)ChatMessageController:(ChatProtocol *)chatprotocol;

@end
