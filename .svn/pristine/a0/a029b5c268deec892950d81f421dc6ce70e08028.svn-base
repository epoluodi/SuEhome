//
//  CommentsBarView.m
//  SuEhome
//
//  Created by Stereo on 2016/11/16.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "CommentsBarView.h"
#import <Common/PublicCommon.h>

@implementation CommentsBarView
@synthesize delegate;
@synthesize btnreturn;
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
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
    
    btnlike = [[UIButton alloc] init];
    [btnlike setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnlike.frame = CGRectMake([PublicCommon GetALLScreen].size.width -20-30, 7, 30, 30);
    [btnlike  setImage:[UIImage imageNamed:@"icon_like1"] forState:UIControlStateNormal];
    barbuttncount = 1;
    [self addSubview:btnlike];
    
}

-(void)setBarView:(NSNumber *)showcomment shownum:(NSNumber *)shownum showlike:(NSNumber *)showlike showfav:(NSNumber *)showfav
{
    if ([showfav isEqual:@1])
    {
        barbuttncount ++;
        btnfav = [[UIButton alloc] init];
        [btnfav setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnfav.frame = CGRectMake([PublicCommon GetALLScreen].size.width -(20 *barbuttncount) -(30 *barbuttncount), 7, 30, 30);
        [btnfav  setImage:[UIImage imageNamed:@"icon_fav1"] forState:UIControlStateNormal];
        [self addSubview:btnfav];
    }
    if ([shownum isEqual:@1])
    {
        barbuttncount ++;
        btnnum = [[UIButton alloc] init];
        [btnnum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnnum.frame = CGRectMake([PublicCommon GetALLScreen].size.width -(20 *barbuttncount) -(30 *barbuttncount), 7, 30, 30);
        [btnnum  setImage:[UIImage imageNamed:@"bubble1"] forState:UIControlStateNormal];
        [self addSubview:btnnum];
        
    }
    
    if ([showcomment isEqual:@1])
    {
        _comment = [[UIView alloc] init];
        _comment.frame = CGRectMake(10+26 + 20, 7, [PublicCommon GetScreen].size.width -(10+26 + 20) - barbuttncount *(20 + 30) -20, 30);
        _comment.layer.cornerRadius = 16;
        _comment.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.4] CGColor];
        _comment.layer.borderWidth = 0.5;
        _comment.layer.masksToBounds = YES;
        _comment.backgroundColor = [UIColor whiteColor];
        [self addSubview:_comment];
    }
        
}


- (IBAction)clickReturn:(id)sender {
    [delegate clickbtnReturn];
}


@end
