//
//  MeViewController.m
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableList1.h"
#import "MeTableList2.h"

@interface MeViewController ()

@end

@implementation MeViewController
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"我"];
    
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = self;
    table.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"me_t1" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell1"];
    
    nib = [UINib nibWithNibName:@"me_t2" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell2"];
    table.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);

    
    [[[AppInfo getInstance] getUserInfo] addObserver:self forKeyPath:@"photo" options:NSKeyValueObservingOptionNew context:nil];
    
    // Do any additional setup after loading the view.
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"keypath %@",keyPath);
    NSLog(@"change %@",change);
    NSLog(@"object %@",object);
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      [self setNavTitleHide:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        [table reloadData];
}
-(void)dealloc
{
    [[[AppInfo getInstance] getUserInfo]  removeObserver:self forKeyPath:@"photo"];
}

#pragma mark tabledelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 3;
        case 2:
            return 1;
        case 3:
            return 1;
    }
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            
        case 1:
        case 2:
        case 3:
            return 20;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 100;
            
        case 1:
        case 2:
        case 3:
            return 60;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MeTableList2 *mt2 ;
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0)
            {
                MeTableList1 *mt1 = [table dequeueReusableCellWithIdentifier:@"cell1"];
                mt1.name.text = [[AppInfo getInstance] getUserInfo].nickName;
                mt1.loginname.text = [NSString stringWithFormat:@"登录名:%@",[[AppInfo getInstance]  getUserInfo].loginName];
                [mt1.nickimg setMediaIdLoadImg:[[AppInfo getInstance] getUserInfo].photo filesize:@""];
                return mt1;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    mt2 = [table dequeueReusableCellWithIdentifier:@"cell2"];
                    [mt2 setList:SCORE title:@"我的积分"];
                    return mt2;
                case 1:
                    mt2 = [table dequeueReusableCellWithIdentifier:@"cell2"];
                    [mt2 setList:FAV title:@"我的收藏"];
                    return mt2;
                case 2:
                    mt2 = [table dequeueReusableCellWithIdentifier:@"cell2"];
                    [mt2 setList:FAMILYLIST title:@"亲情账号"];
                    return mt2;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    mt2 = [table dequeueReusableCellWithIdentifier:@"cell2"];
                    [mt2 setList:SETTING title:@"设置"];
                    return mt2;
            }
            break;

        case 3:
            switch (indexPath.row) {
                case 0:
                    mt2 = [table dequeueReusableCellWithIdentifier:@"cell2"];
                    [mt2 setList:ABOUT title:@"关于"];
                    return mt2;
            }
            break;
    }

    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            
        case 0:
            [self performSegueWithIdentifier:@"showselfinfo" sender:self];
            break;
        case 3:
            
            if (indexPath.row == 0)
            {
                [self performSegueWithIdentifier:@"showabout" sender:self];
                return;
            }
            break;
        case 2:
            if (indexPath.row == 0)
            {
                [self performSegueWithIdentifier:@"showsetting" sender:self];
                return;
            }
            break;
            

    }
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
