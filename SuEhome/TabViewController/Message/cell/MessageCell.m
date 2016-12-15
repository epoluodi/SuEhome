//
//  MessageCell.m
//  SuEhome
//
//  Created by Stereo on 2016/12/15.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MessageCell.h"
#import "AppCommon.h"

@implementation MessageCell
@synthesize msgeimg,msgetitle,msgcontent;


-(void)awakeFromNib
{
    [super awakeFromNib];
    msgmark.font = [UIFont systemFontOfSize:14];
    msgmark.textColor = [UIColor whiteColor];
    
    msgdate.font = [UIFont systemFontOfSize:14];
    msgdate.textColor = UIColorFromRGB(0xEAEAEA);
    
    msgstate = [[UIImageView alloc] init];
    [msgstate setImage:[UIImage imageNamed:@"m3"]];
    
    
}


-(void)initCell:(BOOL)showstate msgdate:(NSString *)msgdate mark:(int)mark
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
