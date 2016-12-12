//
//  ChatTableDelegate.m
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "ChatTableDelegate.h"

@implementation ChatTableDelegate
@synthesize groupid;
@synthesize table;

-(instancetype)init
{
    self  = [super init];
    messagelist = [[NSMutableArray alloc] init];
    cellheight = [[NSMutableDictionary alloc] init];
    return self;
}

-(void)getMessageList
{
    
}


-(void)sendMsg:(ChatMessage *)chatmessage
{
    [table beginUpdates];
    [messagelist insertObject:chatmessage atIndex:messagelist.count];
    if (messagelist.count ==1)
        [table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    else
    {
        [table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:messagelist.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    [table endUpdates];
  
}

#pragma mark table delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messagelist.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *_height = [cellheight objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    NSLog(@"行高 %@",_height);
    if (_height)
        return [_height floatValue];
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell;
    SelfTextCell *selftextcell;
    OtherTextCell *othertextcell;
    UINib *nib;
    ChatMessage *chatmessage = messagelist[indexPath.row];
    ChatMessage *chatmessageold = nil;
    if (indexPath.row > 0)
        chatmessageold =messagelist[indexPath.row-1];
    
    switch (chatmessage.messageEnum) {
        case TEXT:
            if (chatmessage.isSelf){
                cell = [table dequeueReusableCellWithIdentifier:chatmessage.msgid];
                if (!cell)
                {
                    nib = [UINib nibWithNibName:@"self_text_cell" bundle:nil];
                    [table registerNib:nib forCellReuseIdentifier:chatmessage.msgid];
                    selftextcell = [table dequeueReusableCellWithIdentifier:chatmessage.msgid];
                    cell = selftextcell;
//                    if (chatmessageold)
//                    {
                        [cell setMsgDt:chatmessageold.msgLongDT newDT:chatmessage.msgLongDT];
//                    }
                    
                    CGSize size= [cell getTextSize:chatmessage.msgcontent];
                    [selftextcell setMsgContentForText:chatmessage.msgcontent size:size];
                    int _cellheight;
                    if (size.height<40)//单行
                        _cellheight = cell.CellHeight +40 ;
                    else//多行
                        _cellheight = cell.CellHeight +(size.height + 15);
                    [cellheight setValue:@(_cellheight) forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                }
            }
            else{
                cell = [table dequeueReusableCellWithIdentifier:chatmessage.msgid];
                if (!cell)
                {
                    nib = [UINib nibWithNibName:@"other_text_cell" bundle:nil];
                    [table registerNib:nib forCellReuseIdentifier:chatmessage.msgid];
                    othertextcell = [table dequeueReusableCellWithIdentifier:chatmessage.msgid];
                 
                    cell = othertextcell;
//                    if (chatmessageold)
//                    {
                        [cell setMsgDt:chatmessageold.msgLongDT newDT:chatmessage.msgLongDT];
//                    }
                    CGSize size= [cell getTextSize:chatmessage.msgcontent];
                    [othertextcell setMsgContentForText:chatmessage.msgcontent size:size];
                    int _cellheight;
                    if (size.height<40)
                        _cellheight = cell.CellHeight +40 ;
                    else
                        _cellheight = cell.CellHeight +(size.height + 15);
                    if (chatmessage.chatEnum == CHAT)
                    {
                        //如果是单聊 隐藏昵称
                        [othertextcell setHideNickName:YES];
                    }
                    else
                    {
                        [othertextcell setHideNickName:NO];
                        _cellheight += 16;
                    }
                    
                    [cellheight setValue:@(_cellheight) forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                    
                    
                }
            }
            
            

            return cell;
    }
    
    
    return cell;
}
#pragma mark -


@end
