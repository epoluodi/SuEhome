//
//  MeTableList2.h
//  OldHome
//
//  Created by Stereo on 2016/11/2.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTableViewCell.h"


typedef enum : NSUInteger {
    SCORE,
    FAV,
    FAMILYLIST,
    SETTING,
    ABOUT,
} MELISTTYPE;



@interface MeTableList2 : BaseTableViewCell


@property (weak, nonatomic) IBOutlet UILabel *listtitle;

@property (weak, nonatomic) IBOutlet UIImageView *img;

-(void)setList:(MELISTTYPE)listtype title:(NSString *)title;
@end
