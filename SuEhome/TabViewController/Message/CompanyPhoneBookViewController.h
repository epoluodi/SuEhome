//
//  CompanyPhoneBookViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/11/30.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTabViewController.h"
#import "PhoneBookDataSource.h"

@interface CompanyPhoneBookViewController : BaseTabViewController<PhoneBookTableDelegate>
{
    PhoneBookDataSource *_phonebookds;
    NSString * _mainorgid;
    NSString * _mainorgname;
    
}

@property (weak,nonatomic) NSString * P_mainId;
@property (weak,nonatomic) NSString * P_mainName;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UINavigationItem *navtitle;

@end
