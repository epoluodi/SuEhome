//
//  InfoViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/9.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *bundlepath = [[NSBundle mainBundle] pathForResource:@"WWW" ofType:@""];
    //    ,@"apps/dyyk/html/dyyhkk/dyyhkk.html"
    //    @"apps/apptest/index.html"
    NSString *homeurl = [NSString stringWithFormat:@"file://%@/%@", bundlepath ,@"html/index.html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:homeurl ]]];
    
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavTitleHide:NO];
    [self setNavTitle:@"苏电心桥"];
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
