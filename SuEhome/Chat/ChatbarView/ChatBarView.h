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
#import "RecordButton.h"

#define EMJVIEWHEIGHT 240 //表情高度
#define MOREVIEWHEIGHT 100 //更多高度
#define CHATTEXTONEWORDHEIGHT 21


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
-(void)updateChatTextlayout:(UITextView *)textview ;//更新输入框布局

@end

@interface ChatBarView : UIView
{
    EmjView * emjview;
    MoreView *moreview;
    NSRange _currange;

    RecordButton *recordbtn;
}


@property (weak, nonatomic) IBOutlet UITextView *chattext;
@property (assign) ChatViewEnum chatviewenum;
@property (weak,nonatomic) UIViewController<ChatBarViewDelegate> *delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnrecord;

- (IBAction)clickEmj:(id)sender;
- (IBAction)clcikrecord:(id)sender;
- (IBAction)clickMore:(id)sender;




-(void)initDelegate:(id)target;//设置代理
-(void)updateChatTextlayout;
-(void)closeInputBoard;//关闭键盘
-(void)textdeleteLast;//删除最后一个内容
-(void)insertEmj:(UIImage *)emjImg emjstring:(NSString *)emjstring;//插入表情
//-(void)setChatTextScrollBounds:(Boolean)Bounds;//设置text 的弹簧效果




-(EmjView *)getEmjView;//得到表情view
-(MoreView *)getMoreView;//得到更多view
-(void)closeMoreView;
-(void)closeEmjView;
@end
