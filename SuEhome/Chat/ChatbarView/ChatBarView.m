//
//  ChatBarView.m
//  SuEhome
//
//  Created by Stereo on 2016/12/5.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "ChatBarView.h"
#import <Common/PublicCommon.h>
@implementation ChatBarView
@synthesize chattext;
@synthesize delegate;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    chattext.backgroundColor = [UIColor whiteColor];
    chattext.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
    chattext.layer.borderWidth=0.3;
    chattext.layer.cornerRadius = 6;
    chattext.layer.masksToBounds =YES;
  
    _chatviewenum = NONE;
    //加载表情view
    NSArray *_varry = [[NSBundle mainBundle] loadNibNamed:@"emjview" owner:self options:nil];
    emjview = _varry[0];

    
}


-(EmjView *)getEmjView
{
    emjview.frame = CGRectMake(0,[PublicCommon GetScreen].size.height+EMJVIEWHEIGHT, [PublicCommon GetALLScreen].size.width, EMJVIEWHEIGHT);
    return emjview;
}


-(void)closeInputBoard
{
    _chatviewenum=NONE;
    [chattext resignFirstResponder];
    [emjview removeFromSuperview];
    
}

-(void)closeEmjView
{
    [emjview removeFromSuperview];
}
-(void)initDelegate:(id)target
{
    chattext.delegate = target;
    delegate = target;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)clickEmj:(id)sender {
    [delegate ClickButton:EMJ];
    _chatviewenum = EMJ;
}

- (IBAction)clcikrecord:(id)sender {
    [delegate ClickButton:RECORDSOUND];
    _chatviewenum=RECORDSOUND;
}

- (IBAction)clickMore:(id)sender {
    [delegate ClickButton:MORE];
    _chatviewenum = MORE;
}
@end
