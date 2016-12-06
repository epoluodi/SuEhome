//
//  MoreView.h
//  SuEhome
//
//  Created by Stereo on 2016/12/6.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>





typedef enum :NSUInteger {
    TAKEPHOTO              =  1,
    PHOTOLIBRARY         =  1 << 1,
    
} MORETYPE;



@protocol MoreDelegate

//点击更多里面的菜单
-(void)ClickMore:(MORETYPE)moretype;

@end


@interface MoreView : UIView



@property (weak, nonatomic) IBOutlet UIScrollView *morescroll;
@property (weak,nonatomic) UIViewController<MoreDelegate> *delegate;

-(void)initView:(MORETYPE)moretype;


@end
