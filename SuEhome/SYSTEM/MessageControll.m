//
//  MessageControll.m
//  SuEhome
//
//  Created by Stereo on 2016/12/14.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MessageControll.h"
#import "AppCommon.h"

@implementation MessageControll


-(void)ChatMessageController:(ChatProtocol *)chatprotocol
{
    
    ChatMessage *chatmessage = [[ChatMessage alloc] init];
    T_Member * _tm ;
    T_friendlist *_tf;
    if ([chatprotocol.ope isEqualToString:@"0"])
    {
        chatmessage.groupid = chatprotocol.from;
        chatmessage.chatEnum = CHAT;
        if ([[AppInfo getInstance] getUserInfo].userType == OLDMAN)
        {
            _tf = [[DBmanger getIntance] getFriendInfo:chatprotocol.from];
            chatmessage.sender = _tf.nickname;
            chatmessage.nickimg = _tf.picid;
        }
        else if ([[AppInfo getInstance] getUserInfo].userType == WORKER)
        {
            _tm =[[DBmanger getIntance] getPhoneBookUserInfo:chatprotocol.from];
            chatmessage.sender =_tm.user_name;
            chatmessage.nickimg =_tm.pic_id;
        }
    }
    else if ([chatprotocol.ope isEqualToString:@"1"])
    {
        chatmessage.groupid = chatprotocol.to;
        chatmessage.chatEnum = GROUP;
        if ([[AppInfo getInstance] getUserInfo].userType == WORKER)
        {
            _tm =[[DBmanger getIntance] getPhoneBookUserInfo:chatprotocol.from];
            chatmessage.sender =_tm.user_name;
            chatmessage.nickimg =_tm.pic_id;
        }
    }
    
    chatmessage.senderid = chatprotocol.from;
    chatmessage.msgLongDT = chatprotocol.sendtime;
   
    chatmessage.msgdate = [STCommon getDateTimeForLongDT:[chatprotocol.sendtime doubleValue]];
    chatmessage.createmsgLongDT = chatprotocol.sendtime;
    chatmessage.createmsgdate =[STCommon getDateTimeForLongDT:[chatprotocol.sendtime doubleValue]];
    chatmessage.msgid = chatprotocol.msgid;
    chatmessage.messageEnum = chatprotocol.messageEnum;
    chatmessage.msgstateEnum=SENDFINISH;
    chatmessage.noDisturb = chatprotocol.noDisturb;
    chatmessage.istop = chatprotocol.istop;
    switch (chatmessage.messageEnum) {
        case TEXT:
            chatmessage.msgcontent = [chatprotocol.body objectForKey:@"msg"];
            break;
        case PHOTO:
            chatmessage.msgcontent = [chatprotocol.body objectForKey:@"media"];
            break;
        case AUDIO:
            chatmessage.msgcontent = [chatprotocol.body objectForKey:@"media"];
            break;
        case EAUDIO:
            chatmessage.msgcontent = [chatprotocol.body objectForKey:@"media"];
            break;
    }

    //数据库操作
    // 1 加入会话列表
    // 2 加入消息记录表
    // 3 提示
    
    
}
@end
