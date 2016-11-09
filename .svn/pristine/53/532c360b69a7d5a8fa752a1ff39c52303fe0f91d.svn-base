//
//  CommonCellNoImg.h
//  OldHome
//
//  Created by Stereo on 2016/11/2.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTableViewCell.h"


typedef enum : NSUInteger {
    INDICATOR,
    SWITCH,
    IMAGE,
    NOINDICATOR,
    
} LISTMODE;

@interface CommonCellNoImg : BaseTableViewCell
{
    UISwitch *sw;
    UILabel *labmemo;
    UIImageView *imgview;
}

@property (weak, nonatomic) IBOutlet UILabel *listtitle;


-(void)setListMode:(LISTMODE)listmode;
-(void)setListMemo:(NSString *)memo;
-(void)setSwicth:(BOOL)on;
-(void)setRightSmallImgage:(UIImage *)img;
-(void)setCellSelectState:(BOOL)isselect;
@end
