//
//  SearchTableView.h
//  SuEhome
//
//  Created by Stereo on 2016/12/2.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol SearchTableDelegate

-(void)SelectCell:(NSManagedObject *)Obj;

@end


@interface SearchTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *resultlist;
    
}

@property (weak,nonatomic) NSObject<SearchTableDelegate> *VC;
-(instancetype)init:(NSArray *)result;

@end
