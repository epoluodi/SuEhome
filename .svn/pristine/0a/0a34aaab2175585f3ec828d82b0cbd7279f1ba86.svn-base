//
//  CommonCellNoImg.m
//  OldHome
//
//  Created by Stereo on 2016/11/2.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "CommonCellNoImg.h"
#import <Common/PublicCommon.h>

@implementation CommonCellNoImg
@synthesize listtitle;



-(void)setSwicth:(BOOL)on
{
    if (sw)
        sw.on = on;
}


-(void)setListMemo:(NSString *)memo
{
        if (labmemo)
            labmemo.text = memo;
}

-(void)setRightSmallImgage:(UIImage *)img
{
    if (imgview)
        imgview.image = img;
}

-(void)setCellSelectState:(BOOL)isselect
{
    if (!isselect)
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    else
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
}
-(void)setListMode:(LISTMODE)listmode
{
    switch (listmode) {
        case INDICATOR:
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labmemo = [[UILabel alloc] init];
            labmemo.textAlignment = NSTextAlignmentRight;
            labmemo.textColor = UIColorFromRGB(0x909090);
            labmemo.font = [UIFont systemFontOfSize:14];
            labmemo.frame = CGRectMake([PublicCommon GetScreen].size.width - 150  -40, 60/2 - 35/2, 150, 35);
            [self.contentView addSubview:labmemo];
            
            break;
        case SWITCH:
               self.accessoryType = UITableViewCellAccessoryNone;
            sw = [[UISwitch alloc] init];
            sw.frame = CGRectMake([PublicCommon GetScreen].size.width - sw.frame.size.width  -16, 60/2 - sw.frame.size.height/2, sw.frame.size.width, sw.frame.size.height);
            [self.contentView addSubview:sw];
            break;
        case NOINDICATOR:
            labmemo = [[UILabel alloc] init];
            labmemo.textAlignment = NSTextAlignmentRight;
            labmemo.textColor = UIColorFromRGB(0x909090);
            labmemo.font = [UIFont systemFontOfSize:14];
            labmemo.frame = CGRectMake([PublicCommon GetScreen].size.width - 150  -16, 60/2 - 35/2, 150, 35);
            [self.contentView addSubview:labmemo];
            
            break;
        case IMAGE:
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            imgview = [[UIImageView alloc] init];
            imgview.frame = CGRectMake([PublicCommon GetScreen].size.width - 24  -40, 60/2 - 24/2, 24, 24);
            [self.contentView addSubview:imgview];
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
