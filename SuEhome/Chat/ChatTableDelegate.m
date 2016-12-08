//
//  ChatTableDelegate.m
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "ChatTableDelegate.h"

@implementation ChatTableDelegate



#pragma mark table delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
    SelfTextCell *selftextcell;
    OtherTextCell *othertextcell;
    
    if (indexPath.row == 0 || indexPath.row==1)
    {
        selftextcell = [tableView dequeueReusableCellWithIdentifier:@"selftextcell"];
        return selftextcell;
    }else
    {
        othertextcell = [tableView dequeueReusableCellWithIdentifier:@"othertextcell"];
        return othertextcell;
    }
    
    return nil;
}
#pragma mark -


@end
