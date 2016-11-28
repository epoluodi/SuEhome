//
//  UserInfoHeadCell.h
//  SuEhome
//
//  Created by Stereo on 2016/11/28.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface UserInfoHeadCell : BaseTableViewCell
{
    UILabel *_labnickname;
    UIImageView *_imgsex;
}
@property (weak, nonatomic) IBOutlet STImageView *nickimg;
@property (weak,nonatomic) NSString *nickName;
@property (weak,nonatomic) NSNumber *nickSex;


-(void)setUserInfo;
@end
