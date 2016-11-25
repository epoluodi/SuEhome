//
//  UserInfoSampleViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/11/25.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewController.h"

@interface UserInfoSampleViewController : BaseTabViewController<UITableViewDelegate,UITableViewDataSource>
{

}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UINavigationItem *navtitle;

@end
