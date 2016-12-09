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
    if (indexPath.row == 0 || indexPath.row==1)
    {
     
        return 84;
    }else
    {
        return 84 + 4+12;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell;
    SelfTextCell *selftextcell;
    OtherTextCell *othertextcell;
    
    ChatMessage *chatmessage = messagelist[indexPath.row];
    ChatMessage *chatmessageold = nil;
    if (indexPath.row > 0)
        chatmessageold =messagelist[indexPath.row-1];
    
    switch (chatmessage.messageEnum) {
        case TEXT:
            if (chatmessage.isSelf)
            {
                selftextcell = [table dequeueReusableCellWithIdentifier:@"selftextcell"];
                
            }
            cell = selftextcell;
            if (chatmessageold)
            {
                [cell setMsgDt:chatmessageold.msgLongDT newDT:chatmessage.msgLongDT];
            }
            
            return cell;
    }
    
    
    return cell;
}
#pragma mark -


@end
