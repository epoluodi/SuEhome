//
//  PersonCell.h
//  SuEhome
//
//  Created by Stereo on 2016/11/25.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STImageView.h"
#import "BaseTableViewCell.h"

@interface PersonCell :BaseTableViewCell


@property (weak, nonatomic) IBOutlet STImageView *nickimg;
@property (weak, nonatomic) IBOutlet UILabel *nickname;



@end
