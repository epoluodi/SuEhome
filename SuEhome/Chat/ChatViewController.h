//
//  ChatViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/12/5.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTabViewController.h"
#import "ChatBarView.h"
#import "ChatTableDelegate.h"
#define CHATBARHEIGHT 50



@interface ChatViewController : BaseTabViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,ChatBarViewDelegate,MoreDelegate,EmjDelegate,RecordDelegate>
{
    UIBarButtonItem *btnright;
    ChatBarView *chatbarview;
    ChatTableDelegate *tabledelegate;
    
}


@property (assign) ChatEnum chatmode;//聊天类型
@property (weak, nonatomic) IBOutlet UINavigationItem *chattitle;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *chatbar;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chattextheight;




@end
