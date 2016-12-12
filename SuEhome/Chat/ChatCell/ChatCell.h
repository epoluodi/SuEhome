//
//  ChatCell.h
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Common/PublicCommon.h>


#define TEXTWIDTH [PublicCommon GetScreen].size.width -70 - 8-8-40 //最大当前文本显示宽度

@interface ChatCell : UITableViewCell
{
    @public
    UIImage *infobackimgleft,*infobackimgright;
    UILabel *labcontent;
    UILabel *labdt;
}

@property (assign) int16_t CellHeight;


//基类方法，让机场者重载
-(CGSize)getTextSize:(NSString *)content;//得到当前文本需要显示的尺寸
-(void)setMsgContentForText:(NSString *)content size:(CGSize)size;//设置文本显示
-(BOOL)setMsgDt:(NSString *)olddt newDT:(NSString *)newdt; //设置显示消息时间 YES 大于60  NO小于
@end
