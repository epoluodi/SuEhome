//
//  ChatViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/12/5.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTabViewController.h"
#import "ChatBarView.h"

#define CHATBARHEIGHT 50

typedef enum : NSUInteger {
    SINGLE,//单聊
    GROUP,//群聊
} CHATMODE;

@interface ChatViewController : BaseTabViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,ChatBarViewDelegate,MoreDelegate,EmjDelegate>
{
    UIBarButtonItem *btnright;
    ChatBarView *chatbarview;

    
}


@property (assign) CHATMODE chatmode;//聊天类型
@property (weak, nonatomic) IBOutlet UINavigationItem *chattitle;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *chatbar;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;


@end
