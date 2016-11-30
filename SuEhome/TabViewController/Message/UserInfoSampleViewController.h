//
//  UserInfoSampleViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/11/25.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewController.h"
#import "T_friendlist+CoreDataClass.h"
#import "T_Member+CoreDataClass.h"
#import "CommonCellNoImg.h"

@interface UserInfoSampleViewController : BaseTabViewController<UITableViewDelegate,UITableViewDataSource>
{

}

@property (weak,nonatomic) T_Member * T_member;
@property (weak,nonatomic) T_friendlist * T_Friend;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UINavigationItem *navtitle;

@end
