//
//  WebViewRequest.m
//  SuEhome
//
//  Created by Stereo on 2016/11/10.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "WebViewRequest.h"
#import "CDVViewController.h"

@implementation WebViewRequest


-(void)open:(CDVInvokedUrlCommand *)command
{
    CDVViewController *cdv = (CDVViewController *)self.viewController;
    [self.commandDelegate runInBackground:^{
        [cdv OnMessage:@"openwindows" command:command];
    }];
}
@end
