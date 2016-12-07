//
//  ChatBarView.m
//  SuEhome
//
//  Created by Stereo on 2016/12/5.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "ChatBarView.h"
#import <Common/PublicCommon.h>
#import "Emj.h"
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
    chattext.font = [UIFont systemFontOfSize:18];
    _chatviewenum = NONE;
    //加载表情view
    NSArray *_varry = [[NSBundle mainBundle] loadNibNamed:@"emjview" owner:self options:nil];
    emjview = _varry[0];
    _varry = [[NSBundle mainBundle] loadNibNamed:@"moreview" owner:self options:nil];
    moreview = _varry[0];

    [moreview initView:TAKEPHOTO|PHOTOLIBRARY];
    
}


-(EmjView *)getEmjView
{
    emjview.frame = CGRectMake(0,[PublicCommon GetScreen].size.height+EMJVIEWHEIGHT, [PublicCommon GetALLScreen].size.width, EMJVIEWHEIGHT);
    return emjview;
}

-(MoreView *)getMoreView
{
    moreview.frame = CGRectMake(0,[PublicCommon GetScreen].size.height+MOREVIEWHEIGHT, [PublicCommon GetALLScreen].size.width, MOREVIEWHEIGHT);
    return moreview;
}


//关闭所有chatbar的窗口
-(void)closeInputBoard
{
    _chatviewenum=NONE;
    [chattext resignFirstResponder];
    [emjview removeFromSuperview];
    [moreview removeFromSuperview];
    
}

-(void)closeEmjView
{
    [emjview removeFromSuperview];
}

-(void)closeMoreView
{
    [moreview removeFromSuperview];
}


-(void)initDelegate:(id)target
{
    chattext.delegate = target;
    delegate = target;
    moreview.delegate = target;
    emjview.delegate = target;
}

-(void)textdeleteLast
{
    if (chattext.text.length == 0)
        return;
    
    if (chattext.text.length > 3){
        if ([[chattext.text substringFromIndex:chattext.text.length -2] isEqualToString:@"!]"])
        {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[\\!\\w*\\!\\]" options:NSRegularExpressionCaseInsensitive error:nil];
            NSArray *result = [regex matchesInString :chattext.text options:0 range:NSMakeRange(0, [chattext.text length])];
            if (result.count != 0)
            {
                NSTextCheckingResult *checkresult =result[result.count-1];
                chattext .text = [chattext.text substringToIndex:checkresult.range.location];
                _currange = NSMakeRange(checkresult.range.location, 0);
                return;
            }
        }
    }
    
    chattext .text = [chattext.text substringToIndex:chattext.text.length-1];
    if (chattext.text.length == 0){
        _currange = chattext.selectedRange;
        return;
    }
    _currange = NSMakeRange(chattext.text.length, 0);
}

-(void)insertEmj:(UIImage *)emjImg emjstring:(NSString *)emjstring
{


   chattext.attributedText =  [Emj getAttrString:chattext.text addimg:emjImg EmjString:emjstring Range:_currange];
    _currange = NSMakeRange(_currange.location+emjstring.length, 0);
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
    _currange =  chattext.selectedRange;
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
