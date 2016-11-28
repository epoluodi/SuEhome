//
//  STImageView.m
//  OldHome
//
//  Created by Stereo on 2016/11/3.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "STImageView.h"
#import "AppCommon.h"
#import "HttpFile.h"

@implementation STImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setRadius
{
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
}

-(void)setMediaIdLoadImg:(NSString *)mediaid filesize:(NSString *)size
{
    if ([STCommon CheckFileForcache:mediaid filetype:[NSString stringWithFormat:@"%@.jpg",size]])
    {
        NSString *path = [FileCommon getCacheDirectory];
        NSString *filepath =[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.jpg",mediaid,size]];
        
        UIImage *img = [UIImage imageWithContentsOfFile:filepath];
        self.image = img;
    }
    else
    {
        __block __weak __typeof(self) weakself = self;
        
        BACK(^{
            HttpFile *httpfile = [[HttpFile alloc] init:JPG];
            NSData * jpgdata = [httpfile downloadFile:mediaid fileSize:@""];
            if (jpgdata)
            {
                MAIN(^{
                    UIImage *img = [UIImage imageWithData:jpgdata];
                    weakself.image = img;
                });
            }
        });
        
        
        
    }
}
@end
