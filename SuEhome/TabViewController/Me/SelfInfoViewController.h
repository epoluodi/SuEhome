//
//  SelfInfoViewController.h
//  OldHome
//
//  Created by Stereo on 2016/11/3.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseTabViewController.h"
#import "STImageView.h"
#import "CommonInputViewController.h"
@interface SelfInfoViewController : BaseTabViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,CommonInputDelgate>
{
    UIImagePickerController *pickerview;
    STImageView *cellimg;
    
}


@property (weak, nonatomic) IBOutlet UITableView *table;



@end
