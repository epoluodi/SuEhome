//
//  CordovaWebViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "CordovaWebViewController.h"
#import "SingleWebViewController.h"


@interface CordovaWebViewController ()

@end

@implementation CordovaWebViewController
@synthesize IsUserWebTitle;
@synthesize IsHideNavBar;
@synthesize webTitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    isHideNavBar = NO;
    
    if (IsHideNavBar)
    {
        isHideNavBar = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.navigationController.navigationBar.hidden = YES;
    }
    _webtitle = @"";
    if (!IsUserWebTitle){
        self.navigationItem.title = webTitle;
        _webtitle=webTitle;
    }
    
    _JSLIst = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
}

-(void)ClickBtnRight
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{

    self.navigationItem.title = _webtitle;
    if (isHideNavBar)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.navigationController.navigationBar.hidden = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationItem.title = @"";
    
    if (isHideNavBar)
    {
        self.automaticallyAdjustsScrollViewInsets = YES;
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        self.navigationController.navigationBar.hidden = NO;
        [self.webView.scrollView setContentOffset:CGPointMake(0, -64)];;
    }
}


-(void)OnMessage:(NSString *)Action command:(CDVInvokedUrlCommand *)command
{
    
    __block __weak __typeof(self) weakself = self;
    NSDictionary* arg ;
    [super OnMessage:Action command:command];
    if ([Action isEqualToString:@"title"])//设置web title
    {
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        arg = [command.arguments objectAtIndex:0];

        
        dispatch_async(MAINQ, ^{
                weakself.navigationItem.title = [arg objectForKey:@"title"];
        });
        return;
    }else if ([Action isEqualToString:@"navbar"])//nav bar控制
    {
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        arg = [command.arguments objectAtIndex:0];
        
        dispatch_async(MAINQ, ^{
            if ([[ arg objectForKey:@"hide"] isEqualToString:@"true"])
            {
                isHideNavBar = YES;
                weakself.navigationController.navigationBar.hidden = YES;
               
                weakself.automaticallyAdjustsScrollViewInsets=NO;
                [UIView animateWithDuration:0.4f animations:^{
                    weakself.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                }];
            }else if  ([[ arg objectForKey:@"hide"] isEqualToString:@"false"])
            {
          
                weakself.automaticallyAdjustsScrollViewInsets = YES;
                weakself.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
                weakself.navigationController.navigationBar.hidden = NO;
                isHideNavBar = NO;
                [UIView animateWithDuration:0.4f animations:^{
                    [weakself.webView.scrollView setContentOffset:CGPointMake(0, -64)];
                }];
            }
        });
        return;
    }else if ([Action isEqualToString:@"openwindows"])// 打开窗口
    {
        arg = [command.arguments objectAtIndex:0];
        
        NSString * _url = [arg objectForKey:@"url"];
        
        dispatch_async(MAINQ, ^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SingleWebViewController *webviewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"SingleWebViewController"];
        
            //临时
            NSString *bundlepath = [[NSBundle mainBundle] pathForResource:@"WWW" ofType:@""];
            NSString *homeurl = [NSString stringWithFormat:@"file://%@/%@", bundlepath ,@"html/index.html"];
            webviewcontroller.loadUrl =homeurl;
            
            if (![[NSNull null] isEqual: [arg objectForKey:@"mode" ]])
            {
                if ([[arg objectForKey:@"mode"] isEqualToString:@"NOTITLE"])
                {
                    webviewcontroller.IsHideNavBar=YES;
                }
            }
          
            if (![[NSNull null] isEqual: [arg objectForKey:@"title" ]])
            {
                NSString *_webtitle=[arg objectForKey:@"title"];
                webviewcontroller.IsUserWebTitle=NO;
                webviewcontroller.webTitle =[arg objectForKey:@"title"];
            }
            else
                webviewcontroller.IsUserWebTitle=YES;
//            webviewcontroller.loadUrl =_url;

    
            [weakself.navigationController pushViewController:webviewcontroller animated:YES];

        });
        

    }else if ([Action isEqualToString:@"closewindows"])//关闭窗口
    {
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        NSString *function = [command.arguments objectAtIndex:0];
        dispatch_async(MAINQ, ^{

            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            
            // 发送通知. 其中的Name填写第一界面的Name， 系统知道是第一界面来相应通知， object就是要传的值。 UserInfo是一个字典， 如果要用的话，提前定义一个字典， 可以通过这个来实现多个参数的传值使用。
            NSDictionary *dict =nil;
            if (function)
            {
                dict = [NSDictionary dictionaryWithObjectsAndKeys:function,@"function", nil];
            }
            
            [center postNotificationName:@"closeViewController" object:nil userInfo:dict];
            
            [self.navigationController popViewControllerAnimated:YES];
        });

    }else if ([Action isEqualToString:@"closeEvent"])//注册  关闭事件
    {
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        arg = [command.arguments objectAtIndex:0];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"closeViewControllerNotification" object:nil userInfo:arg];
        
    }else if ( [Action isEqualToString:@"BarBtnRight"] )
    {
        arg = [command.arguments objectAtIndex:0];
        
        dispatch_async(MAINQ, ^{
            if ([[arg objectForKey:@"hide"] isEqualToString:@"YES"])
            {
                [_JSLIst removeAllObjects];
                btnright = nil;
                [self.navigationItem setRightBarButtonItem:nil];
                return;
            }
            else
            {
          
                btnright = nil;
                btnright = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[arg objectForKey:@"type"]] style:UIBarButtonItemStylePlain target:weakself action:@selector(ClickBtnRight)];
                
                [self.navigationItem setRightBarButtonItem:btnright];
            }
            [_JSLIst removeAllObjects];
            if ([[arg objectForKey:@"mode"] isEqualToString:@"button"])
            {
                [_JSLIst addObject:[arg objectForKey:@"function"]];
            }else if ([[arg objectForKey:@"mode"] isEqualToString:@"list"])
            {
                
            }
        });
     
    }
    
}




-(void)callJS:(NSString *)js
{
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}



#pragma mark webview delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"请求地址：%@",request.URL.absoluteString);
    if ([request.URL.absoluteString containsString:@"stereo://prefile/"])
    {
        //显示个人信息
        return NO;
    }
    
    
    return [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];

    if (IsUserWebTitle){
        
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        _webtitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.navigationItem.title = _webtitle;
    }
}

#pragma mark -



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
