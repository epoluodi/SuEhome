//
//  MeTableList1.h
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "STImageView.h"

@interface MeTableList1 : BaseTableViewCell


//头像
@property (weak, nonatomic) IBOutlet  STImageView *nickimg;

//名称
@property (weak, nonatomic) IBOutlet UILabel *name;
//登录名称
@property (weak, nonatomic) IBOutlet UILabel *loginname;
//二维码图标
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeimg;


@end
