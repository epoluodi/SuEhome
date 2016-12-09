//
//  ChatTableDelegate.h
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SelfTextCell.h"
#import "OtherTextCell.h"
#import "ChatMessage.h"

@interface ChatTableDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray<ChatMessage *>* messagelist;
    
}

@property (weak,nonatomic)NSString *groupid;//当前聊天的标识
@property (weak,nonatomic)UITableView *table;


-(void)getMessageList;//获取当前聊天记录

//发送消息
-(void)sendMsg:(ChatMessage *)chatmessage;
@end
