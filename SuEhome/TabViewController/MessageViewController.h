//
//  MessageViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/11/23.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewController.h"
#import "AppCommon.h"
#import "SearchView.h"

@interface MessageViewController : BaseTabViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UISearchBar *searchbar;
    NSArray* _messagelist;
    
    SearchView *searchview;
    UIVisualEffectView *_backview;
    
    UIButton *cancelButton;
    
    BOOL IsSearchMode;
    
    
    UIButton *rightbtn1,*rightbtn2;
}
@property (weak, nonatomic) IBOutlet UITableView *table;


@end
