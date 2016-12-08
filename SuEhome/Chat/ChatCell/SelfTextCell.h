//
//  SelfTextCell.h
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STImageView.h"
#import "ChatCell.h"

@interface SelfTextCell : ChatCell


@property (weak, nonatomic) IBOutlet UIView *viewdt;
@property (weak, nonatomic) IBOutlet STImageView *nickimg;
@property (weak, nonatomic) IBOutlet UIImageView *info;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infomaginright;//default 70



@end
