//
//  SelfTextCell.m
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "SelfTextCell.h"

@implementation SelfTextCell
@synthesize viewdt;
@synthesize nickimg;
@synthesize info;
@synthesize infomaginright;
@synthesize CellHeight;
- (void)awakeFromNib {
    [super awakeFromNib];
    info.image = infobackimgright;
    [nickimg setRadius];


    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
