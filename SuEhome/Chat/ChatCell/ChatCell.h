//
//  ChatCell.h
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell
{
    @public
    UIImage *infobackimgleft,*infobackimgright;
    
}

@property (assign) int16_t CellHeight;


//基类方法，让机场者重载
-(void)setMsgContent:(NSString *)content;//设置消息内容
-(BOOL)setMsgDt:(NSString *)olddt newDT:(NSString *)newdt; //设置显示消息时间
@end
