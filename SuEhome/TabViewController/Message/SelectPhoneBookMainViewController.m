//
//  SelectPhoneBookMainViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/12/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "SelectPhoneBookMainViewController.h"

@interface SelectPhoneBookMainViewController ()

@end

@implementation SelectPhoneBookMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    right1 =[[UIBarButtonItem alloc] init];
    
    right1.title = @"关闭";
    
    [self.navigationItem setRightBarButtonItem:right1];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
