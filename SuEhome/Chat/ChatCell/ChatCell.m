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
    CellHeight = 8+15+9+18 ;
    
    
    labdt = [[UILabel alloc] init];
    labdt.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    labdt.font = [UIFont systemFontOfSize:12];
    labdt.layer.cornerRadius=4;
    labdt.layer.masksToBounds=YES;
    labdt.textColor=[UIColor whiteColor];
    labdt.textAlignment = NSTextAlignmentCenter;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(CGSize)getTextSize:(NSString *)content
{
    CGRect tmpRect = [content boundingRectWithSize:CGSizeMake(TEXTWIDTH, 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    return tmpRect.size;
}
-(void)setMsgContentForText:(NSString *)content size:(CGSize)size
{
    //子类实现
}

-(BOOL)setMsgDt:(NSString *)olddt newDT:(NSString *)newdt
{
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[olddt doubleValue]];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[newdt doubleValue]];
    NSTimeInterval aTimer = [date2 timeIntervalSinceDate:date1];
    
    NSLog(@"时间差 %f",aTimer);
    if (aTimer > 60){
        CellHeight = 8+15+9+18 ;
        return YES;
    }
    else{
        CellHeight = 15+9 ;
        return NO;
    }
}
@end
