//
//  ChatCell.m
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell
@synthesize CellHeight;
- (void)awakeFromNib {
    [super awakeFromNib];
    infobackimgleft =  [[UIImage imageNamed:@"chat_left"] stretchableImageWithLeftCapWidth:18 topCapHeight:38 ];
    infobackimgright =  [[UIImage imageNamed:@"chat_right"] stretchableImageWithLeftCapWidth:18 topCapHeight:38 ];
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setMsgContent:(NSString *)content
{}
-(BOOL)setMsgDt:(NSString *)olddt newDT:(NSString *)newdt
{
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[olddt doubleValue]];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[newdt doubleValue]];
    NSTimeInterval aTimer = [date2 timeIntervalSinceDate:date1];
    
    NSLog(@"时间差 %f",aTimer);
    return YES;
}
@end
