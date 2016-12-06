//
//  ChatViewController.m
//  SuEhome
//
//  Created by Stereo on 2016/12/5.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "ChatViewController.h"
#import <Common/PublicCommon.h>
#import "Emj.h"

@interface ChatViewController ()

@end

@implementation ChatViewController
@synthesize bottom;
@synthesize chattitle;
@synthesize chatbar;
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    btnright = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chatinfo"] style:UIBarButtonItemStylePlain target:self action:@selector(clickChatInfo)];
    
    chattitle.title = @"聊天";
    [chattitle setRightBarButtonItem:btnright];
    
    table.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closetinput)];
    [table addGestureRecognizer:tap];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *_varry = [[NSBundle mainBundle] loadNibNamed:@"chatbarview" owner:self options:nil];
    chatbarview = _varry[0];
    chatbarview.frame =CGRectMake(0, 0, [PublicCommon GetALLScreen].size.width, CHATBARHEIGHT);
    [chatbarview initDelegate:self];
    
    [chatbar addSubview:chatbarview];//添加chatbar
    
    // Do any additional setup after loading the view.
}

-(void)closetinput
{
    [chatbarview closeInputBoard];
    [UIView animateWithDuration:0.4 animations:^{
        bottom.constant = 0;
    }];
}

#pragma mark chattext delegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{

     NSLog(@"文字 %@",textView.attributedText);
    chatbarview.chatviewenum = KEYBOARD;
    [chatbarview closeEmjView];
    [UIView animateWithDuration:0.4 animations:^{
        bottom.constant = 270;
    }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if ([text isEqualToString:@"\n"])
    {
        NSLog(@"发送内容 %@",textView.text);
        return NO;
    }
    
    return YES;
    
}

#pragma mark -


#pragma mark ChatBar Delegate


//bar 操作
-(void)ClickButton:(ChatViewEnum)chatviewenum
{
    switch (chatviewenum) {
        case EMJ:
            if (chatbarview.chatviewenum == EMJ )
                return;
            [chatbarview closeInputBoard];
            [self loadEmjView];
            break;
        case MORE:
            if (chatbarview.chatviewenum == MORE )
                return;
            [chatbarview closeInputBoard];
            [self loadMoreView];
            break;
        case RECORDSOUND:
            break;

    }
}



//更多
-(void)ClickMore:(MORETYPE)moretype
{
    NSLog(@"更多选择 %lu",(unsigned long)moretype);
}

//表情
-(void)ClickEmj:(int)index
{
    if (index == -1)
    {
        
        //删除
        [chatbarview textdeleteLast];
        return;
    }
    UIImage *emgimg=[UIImage imageWithData:[[Emj getEmj] getEmjDataForIndex:index]];
    [chatbarview insertEmj:emgimg];
    

}
#pragma mark -




//加载 表情view
-(void)loadEmjView
{
    [UIView animateWithDuration:0.4 animations:^{
        bottom.constant = 240;
    }];
    
    
    [self.view addSubview:[chatbarview getEmjView ]];
    
    [UIView animateWithDuration:0.4 animations:^{
        [chatbarview getEmjView ].frame= CGRectMake(0,[PublicCommon GetScreen].size.height-EMJVIEWHEIGHT, [PublicCommon GetALLScreen].size.width, EMJVIEWHEIGHT);
   }];
}


//加载 表情view
-(void)loadMoreView
{
    [UIView animateWithDuration:0.4 animations:^{
        bottom.constant = 100;
    }];
    
    
    [self.view addSubview:[chatbarview getMoreView ]];
    
    [UIView animateWithDuration:0.4 animations:^{
        [chatbarview getMoreView ].frame= CGRectMake(0,[PublicCommon GetScreen].size.height-MOREVIEWHEIGHT, [PublicCommon GetALLScreen].size.width, MOREVIEWHEIGHT);
    }];
}

//点击右上角 聊天信息，单聊和群聊，显示不一样
-(void)clickChatInfo
{
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
