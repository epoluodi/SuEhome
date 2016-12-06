//
//  EmjView.m
//  SuEhome
//
//  Created by Stereo on 2016/12/5.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "EmjView.h"
#import "AppCommon.h"
#import <Common/PublicCommon.h>
#import "Emj.h"
@implementation EmjView
@synthesize emjscroll,pageview;
@synthesize delegate;

-(void)awakeFromNib
{
    [super awakeFromNib];
    emjscroll.pagingEnabled=YES;
    emjscroll.bounces=YES;
    emjscroll.contentSize = CGSizeMake([PublicCommon GetScreen].size.width *3,  0);
    emjscroll.scrollEnabled=YES;
    emjscroll.showsHorizontalScrollIndicator=NO;
    emjscroll.showsVerticalScrollIndicator = NO;
    emjscroll.delegate = self;
    
    btnsend = [[UIButton alloc] init];
    [btnsend setTitle:@"发送" forState:UIControlStateNormal];
    btnsend.frame = CGRectMake([PublicCommon GetScreen].size.width - 90, 240-43, 90, 43);
    
    UIImage *back1 = [PublicCommon createImageWithColor:APPCOLOR Rect:CGRectMake(0, 0, 100, 100)];
    UIImage *back2 = [PublicCommon createImageWithColor:UIColorFromRGB(0xFF6347) Rect:CGRectMake(0, 0, 100, 100)];
    
    [btnsend setBackgroundImage:back1 forState:UIControlStateNormal];
    [btnsend setBackgroundImage:back2 forState:UIControlStateHighlighted];
    
    [self addSubview:btnsend];
    
    
    emjwidth =([PublicCommon GetScreen].size.width - 20 - 8*10)  / 9 ;
    [self loadEmjData];
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    delegate.navigationController.interactivePopGestureRecognizer.enabled = YES;
    int index =emjscroll.contentOffset.x /[PublicCommon GetScreen].size.width;
    [pageview setCurrentPage:index];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
      delegate.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

//加载表情
-(void)loadEmjData
{
    NSInteger emjcount = [[Emj getEmj] getCount];
    int page = 0,ii=0,row = 0,col = 0,emjindex = 0;;
    for (int i = 0; i<emjcount +1; i++) {
        UIButton *btnemj= [[UIButton alloc] init];
        
    
        if (i == emjcount)
        {
            btnemj.frame = CGRectMake((page *[PublicCommon GetScreen].size.width)  + 10+(8 *emjwidth) + (8 * 10) , 15 + col *15 + col *emjwidth, emjwidth, emjwidth);
            [btnemj setTag:-1];
            [btnemj setImage:[UIImage imageNamed:@"chat_emj_delete"] forState:UIControlStateNormal];
            [btnemj addTarget:self action:@selector(ClickEmj:) forControlEvents:UIControlEventTouchUpInside];
            [emjscroll addSubview:btnemj];
            return;
        }
        if (ii<9)//第一行
        {
            col= 0;
        }else if (ii <18)
        {
            col =1;
        }else if (ii <26)
        {
            col=2;
        }
        
        if (ii == 26)
        {
            btnemj.frame = CGRectMake((page *[PublicCommon GetScreen].size.width)  + 10+(8 *emjwidth) + (8 * 10) , 15 + col *15 + col *emjwidth, emjwidth, emjwidth);
            [btnemj setTag:-1];
            [btnemj setImage:[UIImage imageNamed:@"chat_emj_delete"] forState:UIControlStateNormal];
            [btnemj addTarget:self action:@selector(ClickEmj:) forControlEvents:UIControlEventTouchUpInside];
            [emjscroll addSubview:btnemj];
            ii = 0;
            row= 0 ;
            col =0;
            page++;
            
            btnemj= [[UIButton alloc] init];
            btnemj.frame = CGRectMake( (page *[PublicCommon GetScreen].size.width) +  10+(row *emjwidth) + (row * 10) , 15 + col *15 + col *emjwidth, emjwidth, emjwidth);
            [btnemj setTag:emjindex];
            [btnemj setImage:[UIImage imageWithData:[[Emj getEmj] getEmjDataForIndex:emjindex]] forState:UIControlStateNormal];
            [btnemj addTarget:self action:@selector(ClickEmj:) forControlEvents:UIControlEventTouchUpInside];
            [emjscroll addSubview:btnemj];
            emjindex++;
            ii++;
            row++;
            if (row >8)
                row= 0;
            continue;
        }
        
        //这个代码比较繁琐，大致意思是：按照总数循环，然后根据分页，分行，分列，进行计算，并且在每页最后一个元素的时候，做一个删除处理，并且追加第二页第一个元素进去，这样以此类推
        btnemj.frame = CGRectMake( (page *[PublicCommon GetScreen].size.width) +  10+(row *emjwidth) + (row * 10) , 15 + col *15 + col *emjwidth, emjwidth, emjwidth);
        [btnemj setTag:emjindex];
        [btnemj setImage:[UIImage imageWithData:[[Emj getEmj] getEmjDataForIndex:emjindex]] forState:UIControlStateNormal];
        [btnemj addTarget:self action:@selector(ClickEmj:) forControlEvents:UIControlEventTouchUpInside];
        [emjscroll addSubview:btnemj];
        emjindex++;
        ii++;
        row++;
        if (row >8)
            row= 0;
    }
}


-(void)ClickEmj:(id)sender
{
    [delegate ClickEmj:((UIButton *)sender).tag];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
