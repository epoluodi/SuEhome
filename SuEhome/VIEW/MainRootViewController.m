//
//  MainRootViewController.m
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MainRootViewController.h"
#import <Common/PublicCommon.h>

@interface MainRootViewController ()

@end

@implementation MainRootViewController
@synthesize labtitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置全局 navbar
    
    UIImage *backbar = [PublicCommon createImageWithColor:APPCOLOR Rect:CGRectMake(0, 0, 100, 100)];
    
    [[UINavigationBar appearance] setBackgroundImage:backbar forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:YES];
    //设置全局tabbar 选中颜色
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
 
    // Do any additional setup after loading the view.
    

    
    labtitle = [[UILabel alloc] init];
    labtitle.font = [UIFont systemFontOfSize:24];
    
    labtitle.frame = CGRectMake(16, 8, [PublicCommon GetALLScreen].size.width-32, 30);
    labtitle.textColor = [UIColor whiteColor];
    
    [self.navigationBar addSubview:labtitle];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}




//转场
//
//-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    return 0.4f;
//    
//}
//
//-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    UIView *generalContentView = [transitionContext containerView];
//    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
//    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        generalContentView.alpha=0;
//        fromView.alpha = 0;
//    
//        
//    } completion:^(BOOL finished) {
//        
//        //Set the final position of every elements transformed
//
//        
//        
//        if ([transitionContext transitionWasCancelled]) {
//            [toView removeFromSuperview];
//        } else {
//            [fromView removeFromSuperview];
//        }
//        
//        // inform the context of completion
//        [transitionContext completeTransition:YES];
//        
//    }];
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
