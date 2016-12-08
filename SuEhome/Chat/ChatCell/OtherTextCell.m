//
//  OtherTextCell.m
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "OtherTextCell.h"

@implementation OtherTextCell
@synthesize viewdt;
@synthesize nickimg,nickname;
@synthesize info;
@synthesize infomaginleft,nicknameheight,infoandnicknameheight;
@synthesize CellHeight;
- (void)awakeFromNib {
    [super awakeFromNib];

    info.image = infobackimgleft;
    [nickimg setRadius];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
