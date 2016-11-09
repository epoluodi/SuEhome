//
//  MeTableList2.m
//  OldHome
//
//  Created by Stereo on 2016/11/2.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MeTableList2.h"

@implementation MeTableList2
@synthesize listtitle,img;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setList:(MELISTTYPE)listtype title:(NSString *)title
{
    listtitle.text= title;
    switch (listtype) {
        case SCORE:
            img.image = [UIImage imageNamed:@"score"];
            break;
        case FAV:
            img.image = [UIImage imageNamed:@"my_fav"];
            break;
        case FAMILYLIST:
            img.image = [UIImage imageNamed:@"family2"];
            break;
        case SETTING:
            img.image = [UIImage imageNamed:@"settings"];
            break;
        case ABOUT:
            img.image = [UIImage imageNamed:@"about"];
            break;
    }
}

@end
