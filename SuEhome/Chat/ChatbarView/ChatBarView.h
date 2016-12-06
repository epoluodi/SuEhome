//
//  ChatBarView.h
//  SuEhome
//
//  Created by Stereo on 2016/12/5.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmjView.h"
#import "MoreView.h"

#define EMJVIEWHEIGHT 240
#define MOREVIEWHEIGHT 100


typedef enum : NSUInteger {
    EMJ,
    MORE,
    KEYBOARD,
    RECORDSOUND,
    NONE,
} ChatViewEnum;


//操作chatbar 的回调
@protocol ChatBarViewDelegate

//点击声音，点击表情，更多的回调
-(void)ClickButton:(ChatViewEnum)chatviewenum;


@end

@interface ChatBarView : UIView
{
    EmjView * emjview;
    MoreView *moreview;
}


@property (weak, nonatomic) IBOutlet UITextView *chattext;
@property (assign) ChatViewEnum chatviewenum;
@property (weak,nonatomic) UIViewController<ChatBarViewDelegate> *delegate;

- (IBAction)clickEmj:(id)sender;
- (IBAction)clcikrecord:(id)sender;
- (IBAction)clickMore:(id)sender;

-(void)initDelegate:(id)target;//设置代理
-(void)closeInputBoard;//关闭键盘
-(void)textdeleteLast;//删除最后一个内容
-(void)insertEmj:(UIImage *)emjImg;//插入表情

-(EmjView *)getEmjView;//得到表情view
-(MoreView *)getMoreView;

-(void)closeMoreView;
-(void)closeEmjView;
@end
