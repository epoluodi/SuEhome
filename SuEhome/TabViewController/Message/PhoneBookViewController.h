//
//  PhoneBookViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/11/30.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTabViewController.h"
#import "SearchView.h"


@interface PhoneBookViewController : BaseTabViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    SearchView *searchview;
    UIVisualEffectView *_backview;
    
    UISearchBar *searchbar;
    BOOL IsSearchMode;
    
    
    NSArray * memberlists;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
