//
//  RecordButton.h
//  SuEhome
//
//  Created by Stereo on 2016/12/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RecordDelegate

-(void)BeginTap;
//-(void)Move:(BOOL)Cancel;
-(void)Finish:(BOOL)Cancel;

@end

@interface RecordButton : UIButton


@property (weak,nonatomic)NSObject<RecordDelegate> *delegate;
@end
