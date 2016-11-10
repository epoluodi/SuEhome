//
//  CordovaWebViewController.h
//  SuEhome
//
//  Created by Stereo on 2016/11/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDV.h"
#import "AppCommon.h"

//基类view 模式
typedef enum : NSUInteger {
    TABVIEWCONTROLLERMODE,//tab 模式
    VIEWCONTROLLERMODE,//独立view模式

} VIEWMODE;

@interface CordovaWebViewController : CDVViewController
{
    @private
    BOOL isHideNavBar;
    NSString  * _webtitle;
    
    
    
    
    @public
    VIEWMODE _viewmode;
    
    
    
}
@property (assign) BOOL IsUserWebTitle;
@property (assign)BOOL IsHideNavBar;
@property (copy,nonatomic) NSString *webTitle;


//设置url
-(void)setLoadUrl:(NSString *)url;


@end
