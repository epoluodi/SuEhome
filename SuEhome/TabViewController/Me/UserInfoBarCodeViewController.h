//
//  UserInfoBarCodeViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/11/18.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewController.h"
#import "STImageView.h"
@interface UserInfoBarCodeViewController : BaseTabViewController


@property (weak, nonatomic) IBOutlet UIView *containerview;
@property (weak, nonatomic) IBOutlet STImageView *nickimg;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIImageView *barcode;



@end
