//
//  UserInfoNickImgCell.m
//  OldHome
//
//  Created by Stereo on 2016/11/3.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "UserInfoNickImgCell.h"

@implementation UserInfoNickImgCell
@synthesize nickimg;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib
{
    [super awakeFromNib];
    nickimg.layer.cornerRadius = 6;
    nickimg.layer.masksToBounds = YES;
    nickimg.userInteractionEnabled=YES;
}
@end
