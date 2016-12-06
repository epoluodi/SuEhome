//
//  EmjView.h
//  SuEhome
//
//  Created by Stereo on 2016/12/5.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PageCount 26

@protocol EmjDelegate

-(void)ClickEmj:(int)index;

@end



@interface EmjView : UIView<UIScrollViewDelegate>
{
    UIButton * btnsend;
    UIButton *btndel;
    
    int emjwidth;
}
@property (weak, nonatomic) IBOutlet UIScrollView *emjscroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageview;
@property (weak,nonatomic) UIViewController<EmjDelegate> *delegate;



@end
