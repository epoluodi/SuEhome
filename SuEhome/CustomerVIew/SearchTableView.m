//
//  SearchTableView.m
//  SuEhome
//
//  Created by Stereo on 2016/12/2.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "SearchTableView.h"
#import "AppCommon.h"
#import "PersonCell.h"
#import "UserInfoSampleViewController.h"
#import "SelfInfoViewController.h"


@implementation SearchTableView
@synthesize VC;

-(instancetype)init:(NSArray *)result
{
    self = [super init];
    resultlist = result;
    self.backgroundColor = [UIColor clearColor];
    UINib *nib= [UINib nibWithNibName:@"personcell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"cell"];
    self.userInteractionEnabled=YES;
    self.dataSource = self;
    self.delegate = self;
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return resultlist.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCell *cell = [self dequeueReusableCellWithIdentifier:@"cell"];
    if ([[AppInfo getInstance] getUserInfo].userType == OLDMAN){
        T_friendlist * tfriend =resultlist[indexPath.row];
        cell.nickname.text =tfriend.nickname;
        [cell.nickimg setMediaIdLoadImg:tfriend.picid filesize:@"_40"];
    }else if ([[AppInfo getInstance] getUserInfo].userType == WORKER)
    {
        T_Member *tm =resultlist[indexPath.row];
        [cell.nickimg setMediaIdLoadImg:tm.pic_id filesize:@"_40"];
        cell.nickname.text = tm.nick_name;
    }
    [cell.nickimg setRadius];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

        return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *labpy = [[UILabel alloc] init];
    labpy.text = @"   联系人-搜索结果";
    labpy.backgroundColor = UIColorFromRGB(0xEAEAEA);
    return labpy;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([[AppInfo getInstance] getUserInfo].userType == OLDMAN){
        T_friendlist * tfriend =resultlist[indexPath.row];
        [VC SelectCell:tfriend];
    }else if ([[AppInfo getInstance] getUserInfo].userType == WORKER)
    {
        T_Member *tm =resultlist[indexPath.row];
        [VC SelectCell:tm];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
