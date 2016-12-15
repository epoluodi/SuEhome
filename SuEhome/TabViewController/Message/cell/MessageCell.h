//
//  MessageCell.h
//  SuEhome
//
//  Created by Stereo on 2016/12/15.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTableViewCell.h"




@interface MessageCell : BaseTableViewCell
{
    UILabel *msgmark;
    UILabel *msgdate;
    UIImageView *msgstate;
}


@property (weak, nonatomic) IBOutlet STImageView *msgeimg;
@property (weak, nonatomic) IBOutlet UILabel *msgetitle;
@property (weak, nonatomic) IBOutlet UILabel *msgcontent;


//设置状态显示
-(void)initCell:(BOOL)showstate msgdate:(NSString *)msgdate mark:(int)mark;

@end
