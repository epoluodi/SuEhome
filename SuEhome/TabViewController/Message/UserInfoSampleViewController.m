//
//  UserInfoSampleViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/25.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "UserInfoSampleViewController.h"

@interface UserInfoSampleViewController ()

@end

@implementation UserInfoSampleViewController
@synthesize table;
@synthesize navtitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    navtitle.title = @"详细信息";
    


    
    // Do any additional setup after loading the view.
}




#pragma mark tabledelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        case 2:
            return 1;
    }
    return 0;
}






#pragma mark -
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
