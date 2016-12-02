//
//  ContactViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/11/24.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchView.h"
#import "BaseTabViewController.h"
#import "PersonCell.h"
#import "SearchTableView.h"


@interface ContactViewController : BaseTabViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SearchTableDelegate>
{
    SearchView *searchview;
    UIVisualEffectView *_backview;
    
    UISearchBar *searchbar;
    NSArray* _contractslist;
    
    NSArray *PYlist;
    NSMutableArray<NSString *> *selectlistpy;
    NSMutableArray *friendlist;//好友数据存放，根据拼音 分组
    SearchTableView *_stable;
    
    
    BOOL IsSearchMode;
}

@property (weak, nonatomic) IBOutlet UITableView *table;



@end
