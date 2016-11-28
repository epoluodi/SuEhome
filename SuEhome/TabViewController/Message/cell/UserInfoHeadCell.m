//
//  UserInfoHeadCell.m
//  SuEhome
//
//  Created by Stereo on 2016/11/28.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "UserInfoHeadCell.h"

@implementation UserInfoHeadCell




-(void)setUserInfo
{
    _labnickname = [[UILabel alloc] init];
    _imgsex = [[UIImageView alloc] init];
    
    CGSize size=  [_nickName sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:24]}];
    _labnickname.frame = CGRectMake(8+75+10, 50 - size.height /2, size.width, size.height);
    _labnickname.text = _nickName;
    _labnickname.font = [UIFont systemFontOfSize:24];
    _labnickname.textColor = [UIColor blackColor];
    [self.contentView addSubview:_labnickname];
    
    
    _imgsex.frame =CGRectMake(8+75+10 +size.width + 10, 50 - 9, 18  , 18);
    
    if ([_nickSex isEqual:@1])
        _imgsex.image = [UIImage imageNamed:@"s1"];
    else
        _imgsex.image = [UIImage imageNamed:@"s2"];
    
    [self.contentView addSubview:_imgsex];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
