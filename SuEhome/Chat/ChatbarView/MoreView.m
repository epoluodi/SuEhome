//
//  MoreView.m
//  SuEhome
//
//  Created by Stereo on 2016/12/6.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MoreView.h"
#import "AppCommon.h"
#import <Common/PublicCommon.h>

@implementation MoreView
@synthesize morescroll;
@synthesize delegate;


-(void)initView:(MORETYPE)moretype
{
    morescroll.pagingEnabled=NO;
    morescroll.bounces=YES;
    morescroll.contentSize = CGSizeMake([PublicCommon GetScreen].size.width+1,  0);
    morescroll.scrollEnabled=YES;
    morescroll.showsHorizontalScrollIndicator=NO;
    morescroll.showsVerticalScrollIndicator = NO;
    
    
    
    UIButton * btn;
    if (moretype & TAKEPHOTO){
        btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(16, 15, 48, 48);
        [btn setBackgroundImage:[UIImage imageNamed:@"input_camera"] forState:UIControlStateNormal];
        [btn setTitle:@"拍照" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTag:0];
        [btn addTarget:self action:@selector(ClickItem:) forControlEvents:UIControlEventTouchUpInside];
        [morescroll addSubview:btn];
    }
    
    if (moretype & PHOTOLIBRARY){
        btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(16 + 16 +48 , 15, 48, 48);
        [btn setBackgroundImage:[UIImage imageNamed:@"input_picture"] forState:UIControlStateNormal];
        [btn setTitle:@"相册" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTag:1];
        [btn addTarget:self action:@selector(ClickItem:) forControlEvents:UIControlEventTouchUpInside];
        [morescroll addSubview:btn];
    }
    
}


-(void)ClickItem:(id)sender
{
    switch ( ((UIButton*)sender).tag) {
        case 0:
            [delegate ClickMore:TAKEPHOTO];
            break;
        case 1:
            [delegate ClickMore:PHOTOLIBRARY];
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
