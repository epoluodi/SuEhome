//
//  CommentsBarView.h
//  SuEhome
//
//  Created by Stereo on 2016/11/16.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentsDelegate

-(void)clickbtnReturn;


@end


@interface CommentsBarView : UIView
{
    UIButton *btnlike,*btnfav,*btnnum;
    UIView *_comment;
    UIImageView *_img1;
    UILabel *_lab1;
    int barbuttncount;
}

@property (weak, nonatomic) IBOutlet UIButton *btnreturn;
@property (weak,nonatomic)UIViewController<CommentsDelegate> * delegate;



-(void)setBarView:(NSNumber *)showcomment shownum:(NSNumber *)shownum showlike:(NSNumber *)showlike showfav:(NSNumber *)showfav;


- (IBAction)clickReturn:(id)sender;





@end
