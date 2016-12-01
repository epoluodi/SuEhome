//
//  PhoneBookDataSouce.h
//  SuEhome
//
//  Created by Stereo on 2016/11/30.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DBmanger.h"


@protocol PhoneBookTableDelegate

-(void)selectCell:(NSDictionary *)CellData;
-(void)NothingData;

@end


typedef enum : NSUInteger {
    DEFAULTMODE,
    SELECTMODE,
} DATASOURCEMODE;
@interface PhoneBookDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_datalist;
    NSString * _mainid;
    DATASOURCEMODE _mode;
}

@property (weak,nonatomic) NSObject<PhoneBookTableDelegate> *delegate;
//根据住ID进行加载
-(instancetype)init:(NSString *)mainid MODE:(DATASOURCEMODE)mode;


@end
