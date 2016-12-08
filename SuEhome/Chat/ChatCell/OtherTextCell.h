//
//  OtherTextCell.h
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STImageView.h"
#import "ChatCell.h"
@interface OtherTextCell : ChatCell


@property (weak, nonatomic) IBOutlet UIView *viewdt;
@property (weak, nonatomic) IBOutlet STImageView *nickimg;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIImageView *info;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infomaginleft; //default 70
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nicknameheight; //default 12
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoandnicknameheight; //defalut 4










@end
