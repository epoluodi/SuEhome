//
//  PhoneBookDataSouce.m
//  SuEhome
//
//  Created by Stereo on 2016/11/30.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "PhoneBookDataSource.h"
#import "PersonCell.h"
@implementation PhoneBookDataSource
@synthesize delegate;
-(instancetype)init:(NSString *)mainid MODE:(DATASOURCEMODE)mode
{
    self = [super init];
    _datalist = [[NSMutableArray alloc] init];
    _mainid = mainid;
    _mode = mode;
    [self LoadALLInfo];
    return self;
}



#pragma mark table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_datalist.count == 0)
    {
        [delegate NothingData];
        return 0;
    }
    return _datalist.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PersonCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *d = _datalist[indexPath.row];
    if ([[d objectForKey:@"type"] isEqualToString:@"1"])
    {
        T_ORG *to = [d objectForKey:@"obj"];
        cell.nickimg.image = [UIImage imageNamed:@"company"];
        cell.nickname.text = to.org_name;
    }else if([[d objectForKey:@"type"] isEqualToString:@"2"])
    {
        T_DEPT *td =[d objectForKey:@"obj"];
        cell.nickimg.image = [UIImage imageNamed:@"company"];
        cell.nickname.text = td.dept_name;
    }else if([[d objectForKey:@"type"] isEqualToString:@"3"])
    {
        T_Member *tm =[d objectForKey:@"obj"];
        [cell.nickimg setMediaIdLoadImg:tm.pic_id filesize:@"_40"];
        cell.nickname.text = tm.nick_name;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.nickimg setRadius];
    return cell;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d = _datalist[indexPath.row];
    [delegate selectCell:d];
}

#pragma mark  加载数据

-(void)LoadALLInfo
{
    NSArray *arry = [[DBmanger getIntance] getMembersForDept:_mainid];
    for (T_Member *tm in arry) {
        NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:tm,@"obj",@"3",@"type", nil];
        [_datalist addObject:d];
    }
    
    arry = [[DBmanger getIntance] getOrgForOrg:_mainid];
    for (T_ORG *to in arry) {
        NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:to,@"obj",@"1",@"type", nil];
        [_datalist addObject:d];
    }
    
    arry = [[DBmanger getIntance] getDeptForOrg:_mainid];
    for (T_DEPT *td in arry) {
        NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:td,@"obj",@"2",@"type", nil];
        [_datalist addObject:d];
    }
    arry = [[DBmanger getIntance] getDeptForDept:_mainid];
    for (T_DEPT *td in arry) {
        NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:td,@"obj",@"2",@"type", nil];
        [_datalist addObject:d];
    }
    

}

@end
