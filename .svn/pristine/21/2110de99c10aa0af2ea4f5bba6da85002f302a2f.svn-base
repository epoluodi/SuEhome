//
//  BaseTableViewCell.m
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
@synthesize nowVC;
- (void)awakeFromNib {
    [super awakeFromNib];
    selectview = [[UIView alloc] init];
    selectview.frame = self.contentView.frame;
    self.selectedBackgroundView = selectview;
    selectview.backgroundColor = [UIColor redColor];
    self.contentView.backgroundColor= [UIColor whiteColor];
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected){
        
        selectview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.03];

    }
    else{
     
        selectview.backgroundColor = [UIColor clearColor];
    
    }
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
