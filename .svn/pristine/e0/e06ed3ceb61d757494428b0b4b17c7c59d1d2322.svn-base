//
//  MyScoreViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/21.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MyScoreViewController.h"

#import <Common/PublicCommon.h>
#import "MBProgressHUD.h"
#import "HttpScore.h"
#import "ScoreCell.h"


@interface MyScoreViewController ()
{
    __block MBProgressHUD *hud;
}

@end

@implementation MyScoreViewController
@synthesize headview,table;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    numview = [[UIVisualEffectView alloc]initWithEffect:beffect];
    numview.frame = CGRectMake([PublicCommon GetALLScreen].size.width/2 - 90, 254 /2 - 90, 180, 180);
    numview.layer .cornerRadius  = 90;
    numview.layer .masksToBounds=YES;
    numview.layer.opacity = 0.75f;
    numview.layer.borderColor = [[UIColor whiteColor] CGColor];
    numview.layer.borderWidth = 1;
    [headview addSubview:numview];
    
    CGSize size= [@"000" sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:48]}];
    amnumview = [[AMAnimatedNumber alloc] init];
    amnumview.frame =CGRectMake(180/2 -size.width/2, 180/2 - 25, size.width+5, 50);
    amnumview.textFont = [UIFont boldSystemFontOfSize:48];
    amnumview.textColor = [UIColor whiteColor];
    [numview addSubview:amnumview];
    [amnumview setNumbers:@"000" animated:NO direction:AMAnimateNumberDirectionDown];
    
    UINib *nib = [UINib nibWithNibName:@"scorecell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell"];
    

  
    __weak __typeof(self) weakself= self;
    tasks = [[NSArray alloc] init];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = [UIColor clearColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), GLOBALQ, ^{
        
        MAIN(^{
            hud = [[MBProgressHUD alloc] initWithView:weakself.view];
            [weakself.view addSubview:hud];
            [hud show:YES];
        
        });
        HttpScore *httpscore= [[HttpScore alloc] init];
        ReturnData *rd = [httpscore queryDailyScore];
        MAIN(^{
            [hud hide:YES];
            if (!rd || rd.returnCode !=0)
            {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取积分失败，请重新尝试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:action];
                [weakself presentViewController:alert animated:YES completion:nil];
                [weakself.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                
                [[AppInfo getInstance] getUserInfo].score = [rd.returnData objectForKey:@"sumScore"];
                CGSize size= [[[AppInfo getInstance] getUserInfo].score sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:48]}];
                
                amnumview.frame =CGRectMake(180/2 -size.width/2, 180/2 - 25, size.width+5, 50);
                [amnumview setNumbers: [[AppInfo getInstance] getUserInfo].score animated:YES direction:AMAnimateNumberDirectionDown];
                
                
                tasks = [[rd.returnData objectForKey:@"dailyTasks"] copy];
                
                [table reloadData];
                
            }
        });
    });

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tasks.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"    每日任务";
    lab.backgroundColor = [UIColor whiteColor];
    lab.layer.borderWidth=0.5;
    lab.layer.borderColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3]CGColor];
    return lab;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d = tasks[indexPath.row];

    ScoreCell *scorecell  = [table dequeueReusableCellWithIdentifier:@"cell"];

    scorecell.celltitle.text = [d objectForKey:@"dailyTaskName"];
    scorecell.cellmemo.text = [d objectForKey:@"dailyTaskPercentage"];
    switch (indexPath.row) {
        case 0:
            scorecell.img.image = [UIImage imageNamed:@"sigin"];
            break;
        case 1:
            scorecell.img.image = [UIImage imageNamed:@"artical"];
            break;
        case 2:
            scorecell.img.image = [UIImage imageNamed:@"comment"];
            break;
    }
    return scorecell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
