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

@end
