//
//  MainRootViewController.m
//  OldHome
//
//  Created by Stereo on 2016/11/1.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "MainRootViewController.h"
#import <Common/PublicCommon.h>
#import "CordovaWebViewController.h"
#import "RootViewController.h"
#import "LoginViewController.h"
@interface MainRootViewController ()

@end

@implementation MainRootViewController
@synthesize labtitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置全局 navbar
    
    UIImage *backbar = [PublicCommon createImageWithColor:APPCOLOR Rect:CGRectMake(0, 0, 100, 100)];
    
    [[UINavigationBar appearance] setBackgroundImage:backbar forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:YES];
    //设置全局tabbar 选中颜色
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
 
    // Do any additional setup after loading the view.
    
    statusbarstyle = UIStatusBarStyleLightContent;
    
    labtitle = [[UILabel alloc] init];
    labtitle.font = [UIFont systemFontOfSize:24];
    
    labtitle.frame = CGRectMake(16, 8, [PublicCommon GetALLScreen].size.width-32, 30);
    labtitle.textColor = [UIColor whiteColor];
    
    isCloseEvent = NO;
    
    self.delegate = self;
    [self.navigationBar addSubview:labtitle];
    
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    // 注册一个监听事件。第三个参数的事件名， 系统用这个参数来区别不同事件。
    [notiCenter addObserver:self selector:@selector(webViewControllerCloseNotification:) name:Notification_CLOSEVIEWCONTROLLER object:nil];
    [notiCenter addObserver:self selector:@selector(webViewControllerCloseNotification:) name:Notification_CLOSEVIEWCONTROLLEREVENT object:nil];
    
    
    //开始连接MQTT
    
    
    _mqtt = [MQTT getInstance];
    _mqtt.delegate=self;
    [_mqtt ConnectMQTT];
    
    
}


-(void)webViewControllerCloseNotification:(NSNotification *)notification
{
    NSLog(@"通知 %@",notification);
    CordovaWebViewController *cordovaview;
    if ([notification.name isEqualToString:@"closeViewController"])
    {
        if (self.viewControllers.count==2)
        {
            RootViewController *rootview = self.viewControllers[0];
            cordovaview = (CordovaWebViewController *)rootview.selectedViewController;
        }
        else
        {
            cordovaview =self.viewControllers[self.viewControllers.count -2];
        }
        
        [cordovaview callJS:[NSString stringWithFormat:@"%@()",[notification.userInfo objectForKey:@"function"]]];
    }else if ([notification.name isEqualToString:@"closeViewControllerNotification"])
    {
        NSDictionary *dict = notification.userInfo;
        if ([[dict objectForKey:@"eventType"] isEqualToString:@"add"])
        {
            isCloseEvent=YES;
            _callJS = [[dict objectForKey:@"function"] copy];
            _jsArg =[[dict objectForKey:@"arg"] copy];
            if ([NSStringFromClass([[dict objectForKey:@"arg"] class]) isEqualToString:@"__NSDictionaryM"])
            {
                NSData * d = [NSJSONSerialization dataWithJSONObject:[dict objectForKey:@"arg"] options:NSJSONWritingPrettyPrinted error:nil];
                _jsArg  = [[[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding] copy];
            }
            else
                _jsArg =[[dict objectForKey:@"arg"] copy];
            _oldVC = self.viewControllers[self.viewControllers.count -2];
            
        }
        else{
            isCloseEvent = NO;
            _callJS = nil;
            _jsArg = nil;
        }
    }
    
  
    
}




-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (isCloseEvent)
    {
        
        if ([_oldVC isEqual:viewController])
        {
        
            if (self.viewControllers.count==1)
            {
                RootViewController *rootview = (RootViewController *)viewController;
                _oldVC = (CordovaWebViewController *)rootview.selectedViewController;
            }
            NSString *js = [NSString stringWithFormat:@"%@(%@)",_callJS,_jsArg?_jsArg:@""];
            [((CordovaWebViewController *)_oldVC) callJS:js];
            isCloseEvent = NO;
            _jsArg=nil;
            _callJS = nil;
            _oldVC=nil;
        }
        
    }
    NSLog(@"viewlist显示的 %@",self.viewControllers);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//注销
-(void)LogOut
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:Notification_USER_LOGOUT object:nil userInfo:nil];
    
    [[MQTT getInstance] DisConnectMQTT];
    [[AppInfo getInstance] ClearInfo];
    [USER_DEFAULT setObject:@"" forKey:@"userpwd"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginvc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginvc;
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setStatusbarMode:(UIStatusBarStyle)statusmode
{
    statusbarstyle =statusmode;
    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    
    return statusbarstyle;
}


#pragma mark MQTT Delegate

//处理所有MQTT的消息
-(void)OnMessage:(NSString *)msg topic:(NSString *)topic
{
    NSLog(@"收到的信息MQTT\n:%@\n--->%@\n",topic,msg);
    ChatProtocol *chatprotocol;
    SystemProtocol *systemprotocol;
    if ([topic isEqualToString:[MQTT getInstance] .getMQTTConfig.ChatNoice])//处理聊天信息数据
    {
         chatprotocol = [[ChatProtocol alloc] init:msg];
        
        NSDictionary *recpjson = [NSDictionary dictionaryWithObjectsAndKeys:chatprotocol.ope,@"ope",
                                  chatprotocol.msgid,@"msgId",
                                  [[AppInfo getInstance] getUserInfo].userId,@"userId", nil];
        NSData *data = [NSJSONSerialization dataWithJSONObject:recpjson options:NSJSONWritingPrettyPrinted error:nil];
        BACK(^{
                [[MQTT getInstance] sendMessage:receipMsgTopic content:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];//回执
        });
        MessageControll *messageControll = [[MessageControll alloc] init];
        [messageControll ChatMessageController:chatprotocol];
        
        return;
    }
   else if([topic isEqualToString:[MQTT getInstance] .getMQTTConfig.SystemNoice])//处理系统通知消息
   {
       systemprotocol = [[SystemProtocol alloc] init:msg];
       
       NSDictionary *recpjson = [NSDictionary dictionaryWithObjectsAndKeys:systemprotocol.noticeId,@"noticeId",nil];
       NSData *data = [NSJSONSerialization dataWithJSONObject:recpjson options:NSJSONWritingPrettyPrinted error:nil];
       BACK(^{
           [[MQTT getInstance] sendMessage:receiptNoticeTopic content:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];//回执
       });
   }
}



-(void)OnDisConnect
{
    NSLog(@"MQTT断开连接");
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:Notification_MQTTDISCONNECT object:nil userInfo:nil];
}

-(void)OnConnectMqtt
{
    NSLog(@"MQTT连接成功");
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:Notification_MQTTCONNECT object:nil userInfo:nil];
}

-(void)OnConnectError
{
    NSLog(@"MQTT连接错误");
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:Notification_MQTTDISCONNECT object:nil userInfo:nil];
}
#pragma mark -

//转场
//
//-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    return 0.4f;
//    
//}
//
//-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    UIView *generalContentView = [transitionContext containerView];
//    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
//    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        generalContentView.alpha=0;
//        fromView.alpha = 0;
//    
//        
//    } completion:^(BOOL finished) {
//        
//        //Set the final position of every elements transformed
//
//        
//        
//        if ([transitionContext transitionWasCancelled]) {
//            [toView removeFromSuperview];
//        } else {
//            [fromView removeFromSuperview];
//        }
//        
//        // inform the context of completion
//        [transitionContext completeTransition:YES];
//        
//    }];
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
