//
//  RootViewController.m
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "RootViewController.h"
#import "MainRootViewController.h"

@interface RootViewController ()
{
    MainRootViewController *mainnavviewcontroller;

}
@end

@implementation RootViewController
@synthesize meVC;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainnavviewcontroller = (MainRootViewController *)self.navigationController;
    mainnavviewcontroller.rootViewController = self;
    
    meVC = self.viewControllers[3];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    [((MainRootViewController *)(self.navigationController)) setStatusbarMode:UIStatusBarStyleLightContent];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{

    switch (self.selectedIndex) {
        case 0:
       
            break;
            
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
