//
//  SelfTextCell.m
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "SelfTextCell.h"
#import "STCommon.h"

@implementation SelfTextCell
@synthesize viewdt;
@synthesize nickimg;
@synthesize info;
@synthesize infomaginright;
@synthesize dtviewtop,dtviewheight;
- (void)awakeFromNib {
    [super awakeFromNib];
    info.image = infobackimgright;
    [nickimg setRadius];
    viewdt.backgroundColor = [UIColor clearColor];

    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMsgContentForText:(NSString *)content size:(CGSize)size
{
    labcontent = [[UILabel alloc] init];
    labcontent.text =content;
    labcontent.numberOfLines=0;

    labcontent.font = [UIFont systemFontOfSize:18];
    labcontent.textColor = [UIColor whiteColor];
    labcontent.frame = CGRectMake(10, 10, size.width, size.height);
    infomaginright.constant = [PublicCommon GetScreen].size.width - 40-16-(size.width +25);
    [info addSubview:labcontent];
    
    
    
    
}
-(BOOL)setMsgDt:(NSString *)olddt newDT:(NSString *)newdt
{
    
    if (!olddt){
        
        NSString *trandt =[PublicCommon getDateStringWithDT:[STCommon getDateTimeForLongDT:newdt]];
        CGSize size = [trandt sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]}];
        labdt.text = trandt;
        labdt.frame = CGRectMake([PublicCommon GetALLScreen].size.width /2 -(size.width+8)/2 , 2, size.width+8, size.height+3);
        [viewdt addSubview:labdt];
        return YES;
    }
    BOOL r = [super setMsgDt:olddt newDT:newdt];
    if (!r)
    {
        dtviewtop.constant = 0;
        dtviewheight .constant=0;
        viewdt.hidden=YES;
    }
    else
    {
        NSString *trandt =[PublicCommon getDateStringWithDT:newdt];
        CGSize size = [trandt sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]}];
        labdt.text = trandt;
        labdt.frame = CGRectMake([PublicCommon GetALLScreen].size.width /2 -(size.width+8)/2 , 2, size.width+8, size.height+3);
        [viewdt addSubview:labdt];
    }
    return r;
}
@end
