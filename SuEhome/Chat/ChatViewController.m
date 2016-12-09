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
@synthesize bottom,chattextheight;
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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

    
    
    //列表
    UINib *nib = [UINib nibWithNibName:@"self_text_cell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"selftextcell"];
    
    nib = [UINib nibWithNibName:@"other_text_cell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"othertextcell"];
    
    tabledelegate  = [[ChatTableDelegate alloc] init];
    tabledelegate.groupid = @"123";//当前聊天id
    [tabledelegate getMessageList];
    tabledelegate.table = table;
    
    
    table.delegate=tabledelegate;
    table.dataSource = tabledelegate;
    
    // Do any additional setup after loading the view.
}

-(void)closetinput
{
    [chatbarview closeInputBoard];
    [UIView animateWithDuration:0.4 animations:^{
        bottom.constant = 0;
    }];
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.4 animations:^{
        bottom.constant = keyBoardFrame.size.height;
    }];
}


//键盘消失
-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.4 animations:^{
        bottom.constant = 0;
    }];
}



#pragma mark chattext delegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{

    NSLog(@"文字光标位置 %@",  NSStringFromRange(textView.selectedRange));
    chatbarview.chatviewenum = KEYBOARD;
    [chatbarview closeEmjView];
  
}


//输入框变化
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""])
    {
        if (textView.text.length > 3){
            if ([[textView.text substringFromIndex:textView.text.length -2] isEqualToString:@"!]"]){
                [chatbarview textdeleteLast];
                
                return NO;
            }
        }
        [chatbarview updateChatTextlayout];
        return YES;
    }
    if ([text isEqualToString:@"\n"])
    {
        NSLog(@"发送内容 %@",textView.text);
        [self sendText:textView.text];
        return NO;
    }
    [chatbarview updateChatTextlayout];
    return YES;
    
}





-(void)updateChatTextlayout:(UITextView *)textview
{
    NSString *_str = textview.text;
    CGFloat width = textview.frame.size.width -10;
    CGSize size =CGSizeMake(width,50*3);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:textview.font,NSFontAttributeName,nil];
    CGSize updatesize = [_str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    if (CHATTEXTONEWORDHEIGHT == (int)updatesize.height){
        chattextheight.constant=  50;
        chatbarview.frame = CGRectMake(0, 0, chatbarview.frame.size.width, CHATBARHEIGHT);
    }
    else if  (CHATTEXTONEWORDHEIGHT *2 == (int)updatesize.height){
        chattextheight.constant=  70;
        chatbarview.frame = CGRectMake(0, 0, chatbarview.frame.size.width, 70);
    }
    else if  (  (int)updatesize.height>CHATTEXTONEWORDHEIGHT *3){
        chattextheight.constant=  102;
        chatbarview.frame = CGRectMake(0, 0, chatbarview.frame.size.width, 102);
    }

  
    
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
    NSDictionary *d =  [[Emj getEmj] getEmjKeyAndValue:index];
    [chatbarview insertEmj:emgimg emjstring:[d objectForKey:@"emojiwildcard"]];
}

//////录音=============
//点击录音
-(void)BeginTap
{
    NSLog(@"开始录音");
}

//完成
-(void)Finish:(BOOL)Cancel
{
    NSLog(@"结束录音 %d",Cancel);
}
//===============
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


-(void)sendText:(NSString *)text
{
    ChatMessage *chatmessage = [[ChatMessage alloc] init];
    chatmessage.isSelf = YES;
    chatmessage.createmsgLongDT =[STCommon getLongNowDate];
    chatmessage.createmsgdate = [NSDate date];
    chatmessage.msgLongDT =[STCommon getLongNowDate];
    chatmessage.msgdate = [NSDate date];
    chatmessage.senderid = [[AppInfo getInstance] getUserInfo].userId;
    chatmessage.sender =[[AppInfo getInstance] getUserInfo].nickName;
    chatmessage.chatEnum = _chatmode;
    chatmessage.msgcontent = text;
    chatmessage.messageEnum = TEXT;
    chatmessage.groupid = @"";//应该传入 当前聊天标识
    chatmessage.msgid =[[NSUUID UUID] UUIDString];
    NSLog(@"发送结构 %@",chatmessage.createmsgLongDT);
    [tabledelegate sendMsg:chatmessage];
    
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
