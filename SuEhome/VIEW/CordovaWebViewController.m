//
//  CordovaWebViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/11/8.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "CordovaWebViewController.h"
#import "SingleWebViewController.h"
#import "FTPopOverMenu.h"
#import <Common/PublicCommon.h>




@interface CordovaWebViewController ()

@end

@implementation CordovaWebViewController
@synthesize IsUserWebTitle;
@synthesize IsHideNavBar;
@synthesize webTitle;

-(void)setLoadUrl:(NSString *)url
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isHideNavBar = NO;

    [UIApplication sharedApplication].keyWindow.backgroundColor = UIColorFromRGB(0xEAEAEA);
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
    if (_barrightmode == BUTTON)
    {
        NSString *js = _JSLIst[0];
        [self callJS:[NSString stringWithFormat:@"%@()",js]];
        return;
    }else if (_barrightmode == LIST)
    {
        [FTPopOverMenu showFromSenderFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-35,0, 0, 64)
                                  withMenu:menuname
                            imageNameArray:menuicon
                                 doneBlock:^(NSInteger selectedIndex) {
                                     
                                     NSString *js = _JSLIst[selectedIndex];
                                     [self callJS:[NSString stringWithFormat:@"%@()",js]];
                                     
                                 } dismissBlock:^{
                                     
                                     NSLog(@"user canceled. do nothing.");
                                     
                                 }];
    }
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
         [((MainRootViewController *)(self.navigationController)) setStatusbarMode:UIStatusBarStyleDefault];
    }
    else
         [((MainRootViewController *)(self.navigationController)) setStatusbarMode:UIStatusBarStyleLightContent];
  
}


-(void)viewWillDisappear:(BOOL)animated
{
//    self.navigationItem.title = @"";
   
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
    if ([Action isEqualToString:SETWEBTITLE])//设置web title
    {
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        arg = [command.arguments objectAtIndex:0];

        
        dispatch_async(MAINQ, ^{
            weakself.navigationItem.title = [arg objectForKey:@"title"];
            _webtitle=[arg objectForKey:@"title"];
            IsUserWebTitle=NO;
        });
        return;
    }else if ([Action isEqualToString:SETNAVBAR])//nav bar控制
    {
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        arg = [command.arguments objectAtIndex:0];
        
        dispatch_async(MAINQ, ^{
            if ([[ arg objectForKey:@"hide"] isEqualToString:@"true"])
            {
                isHideNavBar = YES;
                weakself.navigationController.navigationBar.hidden = YES;
                [((MainRootViewController *)(self.navigationController)) setStatusbarMode:UIStatusBarStyleDefault];
                weakself.automaticallyAdjustsScrollViewInsets=NO;
                [UIView animateWithDuration:0.4f animations:^{
                    weakself.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                }];
            }else if  ([[ arg objectForKey:@"hide"] isEqualToString:@"false"])
            {
                [((MainRootViewController *)(self.navigationController)) setStatusbarMode:UIStatusBarStyleLightContent];
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
    }else if ([Action isEqualToString:OPENWINDOWS])// 打开窗口
    {
        arg = [command.arguments objectAtIndex:0];
        
        NSString * _url = [arg objectForKey:@"url"];
        
        dispatch_async(MAINQ, ^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SingleWebViewController *webviewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"SingleWebViewController"];
        
            //临时
//            NSString *bundlepath = [[NSBundle mainBundle] pathForResource:@"WWW" ofType:@""];
//            NSString *homeurl = [NSString stringWithFormat:@"file://%@/%@", bundlepath ,@"html/index.html"];
//            webviewcontroller.loadUrl =homeurl;
            
            if (![[NSNull null] isEqual: [arg objectForKey:@"mode" ]])
            {
                if ([[arg objectForKey:@"mode"] isEqualToString:@"NOTITLE"])
                {
                    webviewcontroller.IsHideNavBar=YES;
                }
            }
          
            if ([arg objectForKey:@"title" ])
            {
                NSString *_webtitle=[arg objectForKey:@"title"];
                webviewcontroller.IsUserWebTitle=NO;
                webviewcontroller.webTitle =[arg objectForKey:@"title"];
                
            }
            else
                webviewcontroller.IsUserWebTitle=YES;
            webviewcontroller.loadUrl =_url;

    
            [weakself.navigationController pushViewController:webviewcontroller animated:YES];

        });
        

    }else if ([Action isEqualToString:CLOSEWINDOWS])//关闭窗口
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
            
            [center postNotificationName:Notification_CLOSEVIEWCONTROLLER object:nil userInfo:dict];
            
            [self.navigationController popViewControllerAnimated:YES];
        });

    }else if ([Action isEqualToString:CLOSEEVENT])//注册  关闭事件
    {
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        arg = [command.arguments objectAtIndex:0];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:Notification_CLOSEVIEWCONTROLLEREVENT object:nil userInfo:arg];
        
    }else if ( [Action isEqualToString:SETBARRIGHT] )
    {
        arg = [command.arguments objectAtIndex:0];
        
        dispatch_async(MAINQ, ^{
            if ([[arg objectForKey:@"hide"] isEqualToString:@"YES"])
            {
                [_JSLIst removeAllObjects];
                [menuicon removeAllObjects];
                [menuname removeAllObjects];
                if (_buttonright){
                    [_buttonright removeFromSuperview];
                    _buttonright =  nil;
                }
                
                btnright = nil;
                [self.navigationItem setRightBarButtonItem:nil];
                return;
            }
            else
            {
          
                if (_viewmode == TABVIEWCONTROLLERMODE)
                {
                    if (!_buttonright)
                        _buttonright = [[UIButton alloc] init];
                    [_buttonright setBackgroundImage:[UIImage imageNamed:[arg objectForKey:@"type"]] forState:UIControlStateNormal];
                    _buttonright.frame = CGRectMake([PublicCommon GetALLScreen].size.width - 16-30, self.navigationController.navigationBar.frame.size.height /2 - 30/2, 30, 30);
                    [self.navigationController.navigationBar addSubview:_buttonright];
                    
                    [_buttonright addTarget:self action:@selector(ClickBtnRight) forControlEvents:UIControlEventTouchUpInside];
                }else if (_viewmode == VIEWCONTROLLERMODE)
                {
                    btnright = nil;
                    btnright = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[arg objectForKey:@"type"]] style:UIBarButtonItemStylePlain target:weakself action:@selector(ClickBtnRight)];
                    
                    [self.navigationItem setRightBarButtonItem:btnright];
                }
            }
            [_JSLIst removeAllObjects];
            if ([[arg objectForKey:@"mode"] isEqualToString:@"button"])
            {
                [_JSLIst addObject:[arg objectForKey:@"function"]];
                _barrightmode = BUTTON;
            }else if ([[arg objectForKey:@"mode"] isEqualToString:@"list"])
            {
                _barrightmode = LIST;
                _JSLIst = [arg objectForKey:@"function"];
                
                NSArray *menu = [arg objectForKey:@"menu"];
                
                menuname = [[NSMutableArray alloc] init];
                menuicon = [[NSMutableArray alloc] init];
                
                
                for (NSDictionary *d in menu) {
                    [menuname addObject:[d objectForKey:@"name"]];
                    [menuicon addObject:[d objectForKey:@"icon"]];
                }
                

            }
        });
     
    }else if ([Action isEqualToString:COMMENTS_INIT])
    {
        
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        arg = [command.arguments objectAtIndex:0];

        dispatch_async(MAINQ, ^{
            if (!_commentsbarview)
            {
                NSDictionary *data = [arg objectForKey:@"data"];
                _callbackcommentsjs = [arg objectForKey:@"callback"];
                NSLog(@"评论 json %@",data);
                NSNumber *showcomment =[data objectForKey:@"showComment"];
                NSNumber *showcommentNum = [data objectForKey:@"showCommentsNum"];
                
                NSNumber *showlike = [data objectForKey:@"showLike"];
         
                NSNumber *islike,*isfav;
   
                
                
                
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"commentsview" owner:weakself options:nil];
                _commentsbarview = nib[0];
                _commentsbarview.delegate=weakself;
                
                
                _commentsbarview.frame = CGRectMake(0,[PublicCommon GetScreen].size.height , [PublicCommon GetALLScreen].size.width, 45);
                
                
                [weakself.view addSubview:_commentsbarview];
                [_commentsbarview setBarView:showcomment shownum:showcommentNum showlike:showlike showfav:@1];
                if ([showcommentNum isEqual:@1])
                {
                    NSString *num = [data objectForKey:@"num"];
                    
                    _callbackcommentsnumjs = [data objectForKey:@"numFunction"];
                    [_commentsbarview setNum:num];
                }
                
                isfav = [data objectForKey:@"isFav"];
                [_commentsbarview setFavState:isfav];
                if ([showlike isEqual:@1])
                {
                    islike = [data objectForKey:@"isLike"];
                    [_commentsbarview setLikeState:islike];
                }
     
    
        
                
                [UIView animateWithDuration:0.4 animations:^{
                    weakself.webView.frame = CGRectMake(0, 0, weakself.webView.frame.size.width, weakself.webView.frame.size.height-45);
                    _commentsbarview.frame = CGRectMake(0,[PublicCommon GetScreen].size.height - 45, [PublicCommon GetALLScreen].size.width, 45);
                }];
             
            }
        });
     
        
        
        NSLog(@"评论bar");
        
    }else if ([Action isEqualToString:COMMENTS_UNINIT])
    {
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        
        dispatch_async(MAINQ, ^{
            
            if (_commentsbarview)
            {
            
                [UIView animateWithDuration:0.4f animations:^{
                    
                    weakself.webView.frame = CGRectMake(0, 0, weakself.webView.frame.size.width, [PublicCommon GetScreen].size.height);
                    _commentsbarview.frame = CGRectMake(0,[PublicCommon GetScreen].size.height , [PublicCommon GetALLScreen].size.width, 45);
                    
                    
                } completion:^(BOOL finished) {
                    if (_commentsintputview)
                        [_commentsintputview removeFromSuperview];
                    _commentsintputview = nil;
                    
                    [_commentsbarview removeFromSuperview];
                    _commentsbarview = nil;
                    _callbackcommentsjs = nil;
                    _callbackcommentsnumjs = nil;
                }];
            }
        });
        
    }else if ([Action isEqualToString:COMMENTS_UPDATESTATE])
    {
        if (_viewmode == TABVIEWCONTROLLERMODE)
            return;
        
        arg = [command.arguments objectAtIndex:0];

        dispatch_async(MAINQ, ^{
            
            if (_commentsbarview)
            {
                if ([[arg objectForKey:@"type"] isEqual:@1])
                    [_commentsbarview setFavState:[arg objectForKey:@"ope"]];
                if ([[arg objectForKey:@"type"] isEqual:@2])
                    [_commentsbarview setLikeState:[arg objectForKey:@"ope"]];
                if ([[arg objectForKey:@"type"] isEqual:@3]){
                    
                    [_commentsbarview setNum:[arg objectForKey:@"num"]];
                }
            }
        });
        
    }
}




-(void)callJS:(NSString *)js
{
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}


#pragma mark 评论回调

-(void)clickbtnReturn
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)clickbtnLike:(NSNumber *)state
{
    NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:@2,@"type", state,@"content", nil];
    NSData * jsondata = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strjson = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    [self callJS:[NSString stringWithFormat:@"%@(%@)",_callbackcommentsjs,strjson]];
    
}

-(void)clickbtnFav:(NSNumber *)state
{
    NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"type", state,@"content", nil];
    NSData * jsondata = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strjson = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    [self callJS:[NSString stringWithFormat:@"%@(%@)",_callbackcommentsjs,strjson]];
}

-(void)clickNum
{
        [self callJS:[NSString stringWithFormat:@"%@()",_callbackcommentsnumjs]];
}

-(void)clickComments
{
    __block __weak __typeof(self) weakself = self;
    
    if (!_commentsintputview)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"commentsview" owner:self options:nil];
        _commentsintputview = nib[1];
        _commentsintputview.controller=self;
        _commentsbarview.hidden = YES;
        _commentsintputview.frame = CGRectMake(0,[PublicCommon GetScreen].size.height , [PublicCommon GetALLScreen].size.width, 186);

        [self.view addSubview:_commentsintputview];
        
        [UIView animateWithDuration:0.4 animations:^{
          
            weakself.webView.frame = CGRectMake(0, 0, weakself.webView.frame.size.width, [PublicCommon GetScreen].size.height-186);
            _commentsintputview.frame = CGRectMake(0,[PublicCommon GetScreen].size.height - 186-271, [PublicCommon GetALLScreen].size.width, 186);
           weakself.view.frame = CGRectMake(0, 0, weakself.view.frame.size.width, [PublicCommon GetScreen].size.height-271);

        }];
        
    }
 
    
    
    
}

-(void)clickBtnCancel
{
    __block __weak __typeof(self) weakself = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakself.view.frame = CGRectMake(0, 0, weakself.view.frame.size.width, [PublicCommon GetScreen].size.height);

        weakself.webView.frame = CGRectMake(0, 0, weakself.webView.frame.size.width, [PublicCommon GetScreen].size.height-45);
               [_commentsintputview removeFromSuperview];
        _commentsintputview = nil;
        _commentsbarview.hidden = NO;
    }];
    
}

-(void)clickBtnPublish:( NSString *)content
{

    __block __weak __typeof(self) weakself = self;
    
    [UIView animateWithDuration:0.4 animations:^{
        weakself.view.frame = CGRectMake(0, 0, weakself.view.frame.size.width, [PublicCommon GetScreen].size.height);

        weakself.webView.frame = CGRectMake(0, 0, weakself.webView.frame.size.width, [PublicCommon GetScreen].size.height-45);
        
        [_commentsintputview removeFromSuperview];
        _commentsintputview = nil;
        _commentsbarview.hidden = NO;
    } completion:^(BOOL finished) {
        NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:@3,@"type", content,@"content", nil];
        NSData * jsondata = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
        NSString *strjson = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself callJS:[NSString stringWithFormat:@"%@(%@)",_callbackcommentsjs, strjson]];
        });
        
    }];
 
}
#pragma mark -


#pragma mark webview delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
//    NSString *bundlepath = [[NSBundle mainBundle] pathForResource:@"WWW" ofType:@""];
//    NSURL  *cordovajsurl = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@/%@", bundlepath ,@"cordova.js"]];
//    NSURL  *cordovapluginsjsurl = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@/%@", bundlepath ,@"cordova_plugins.js"]];
//    
//    
//    NSData *cjsfiledata = [NSData dataWithContentsOfURL:cordovajsurl];
//    NSData *cpjsfiledata = [NSData dataWithContentsOfURL:cordovapluginsjsurl];
//    
//    [self callJS:[[NSString alloc] initWithData:cpjsfiledata encoding:NSUTF8StringEncoding ]];
//    [self callJS:[[NSString alloc] initWithData:cjsfiledata encoding:NSUTF8StringEncoding ]];
    
    
    
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
