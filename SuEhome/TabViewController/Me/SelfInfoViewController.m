//
//  SelfInfoViewController.m
//  OldHome
//
//  Created by Stereo on 2016/11/3.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "SelfInfoViewController.h"
#import "UserInfoNickImgCell.h"
#import "CommonCellNoImg.h"
#import <Common/PublicCommon.h>
#import "HttpFile.h"
#import "HttpUserInfo.h"
#import "MBProgressHUD.h"


@interface SelfInfoViewController ()

@end

@implementation SelfInfoViewController
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UINib *nib = [UINib nibWithNibName:@"commoncellnoimg" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    nib = [UINib nibWithNibName:@"userinfo_nickimg" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"cell1"];
    table.backgroundColor = [UIColor clearColor];
    
    table.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
    table.delegate= self;
    table.dataSource=self;
    // Do any additional setup after loading the vi/ew.
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 5;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    return v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0)
        return 80;
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoNickImgCell *nickimgcell ;
    CommonCellNoImg *commoncell;
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0){
                nickimgcell = [table dequeueReusableCellWithIdentifier:@"cell1"];
                [nickimgcell.nickimg setMediaIdLoadImg:[[AppInfo getInstance] getUserInfo].photo filesize:@""];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImg)];
                [nickimgcell.nickimg addGestureRecognizer:tap];
                nickimgcell.selectionStyle = UITableViewCellSelectionStyleNone;
                cellimg = nickimgcell.nickimg;
                return nickimgcell;
            }else if (indexPath.row==1)
            {
                commoncell = [table dequeueReusableCellWithIdentifier:@"cell2"];
                [commoncell setListMode:NOINDICATOR];
                [commoncell setListMemo:[[AppInfo getInstance] getUserInfo].nickName];
                commoncell.listtitle.text = @"姓名";
                return commoncell;
            }else if (indexPath.row==2)
            {
                commoncell = [table dequeueReusableCellWithIdentifier:@"cell2"];
                [commoncell setListMode:IMAGE];
                commoncell.listtitle.text = @"我的二维码";
                [commoncell setRightSmallImgage:[UIImage imageNamed:@"qrcode"]];
                return commoncell;
            }
            break;
        case 1:
            if (indexPath.row==0)
            {
                commoncell = [table dequeueReusableCellWithIdentifier:@"cell2"];
                [commoncell setListMode:NOINDICATOR];
                [commoncell setListMemo:[[AppInfo getInstance] getUserInfo].orgName];
                commoncell.listtitle.text = @"单位";
                [commoncell setCellSelectState:NO];
                return commoncell;
            }else if (indexPath.row==1)
            {
                commoncell = [table dequeueReusableCellWithIdentifier:@"cell2"];
                [commoncell setListMode:NOINDICATOR];
                [commoncell setListMemo:[[AppInfo getInstance] getUserInfo].departName];
                commoncell.listtitle.text = @"部门";
                [commoncell setCellSelectState:NO];
                return commoncell;
            }else if (indexPath.row==2)
            {
                commoncell = [table dequeueReusableCellWithIdentifier:@"cell2"];
                [commoncell setListMode:INDICATOR];
                [commoncell setListMemo:[[AppInfo getInstance] getUserInfo].addr];
                commoncell.listtitle.text = @"详细地址";
                return commoncell;
            }else if (indexPath.row==3)
            {
                commoncell = [table dequeueReusableCellWithIdentifier:@"cell2"];
                [commoncell setListMode:INDICATOR];
                [commoncell setListMemo:[[AppInfo getInstance] getUserInfo].mobile];
                commoncell.listtitle.text = @"手机号";
                return commoncell;
            }else if (indexPath.row==4)
            {
                commoncell = [table dequeueReusableCellWithIdentifier:@"cell2"];
                [commoncell setListMode:INDICATOR];
                [commoncell setListMemo:[[AppInfo getInstance] getUserInfo].email];
                commoncell.listtitle.text = @"邮箱";
                return commoncell;
            }
            break;
            
   
    }
    

    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommonInputViewController *_commoninputvc =(CommonInputViewController *) [storyboard instantiateViewControllerWithIdentifier:@"CommonInputViewController"];

    
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==2)
            {
                [self performSegueWithIdentifier:@"UserInfoBarCode" sender:self];
                return;
            }
            
            break;
        case 1:
            
            if (indexPath.row == 2)
            {
                
                _commoninputvc.delegate=self;
                _commoninputvc.inputEnum = TEXT;
                _commoninputvc.value = [[AppInfo getInstance] getUserInfo].addr;
                [self.navigationController pushViewController:_commoninputvc animated:YES];
            }else if (indexPath.row == 3)
            {
                _commoninputvc.delegate=self;
                _commoninputvc.inputEnum = PHONE;
                _commoninputvc.value = [[AppInfo getInstance] getUserInfo].mobile;
                [self.navigationController pushViewController:_commoninputvc animated:YES];
            }else if (indexPath.row == 4)
            {
                
                _commoninputvc.delegate=self;
                _commoninputvc.inputEnum = EMAIL;
                _commoninputvc.value = [[AppInfo getInstance] getUserInfo].email;
                [self.navigationController pushViewController:_commoninputvc animated:YES];
            
            }
            break;
    }
}


-(void)UpdateValue:(NSString *)value inputtype:(InputEnum)inputtype selfvc:(UIViewController *)selfvc
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), MAINQ, ^{
        
        [hud show:YES];
        
        BACK(^{
        
            HttpUserInfo *httpuserinfo = [[HttpUserInfo alloc] init];
            switch (inputtype) {
                case TEXT:
                    [httpuserinfo setPoseData:value Key:@"detailAddr"];
                    break;
                case PHONE:
                    [httpuserinfo setPoseData:value Key:@"phone"];
                    break;
                case EMAIL:
                    [httpuserinfo setPoseData:value Key:@"email"];
                    break;
                    
            }
            
            ReturnData *rd=  [httpuserinfo updateUserInfo];
            
            
            MAIN(^{
                [hud hide:YES];
                hud=nil;
                
                if (rd.returnCode != 0)
                {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"更新失败，请重新尝试" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                    return ;
                }
                else
                {
                    
                    
                    switch (inputtype) {
                        case TEXT:
                            [[AppInfo getInstance] getUserInfo].addr = value;
                            break;
                        case PHONE:
                            [[AppInfo getInstance] getUserInfo].mobile = value;
                            break;
                        case EMAIL:
                            [[AppInfo getInstance] getUserInfo].email = value;
                            break;
                            
                    }
                    
                    
                    
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"更新成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                    [table reloadData];
                    return ;
                }
                
                
            });

        
        });
    });

    
    

    
}

-(void)clickImg
{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 pickerview = [[UIImagePickerController alloc] init];//初始化
                                 pickerview.delegate = self;
                                 pickerview.allowsEditing = YES;//设置可编辑
                                 UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                                 pickerview.sourceType = sourceType;
                                 [self presentViewController:pickerview animated:YES completion:nil];//进入照相界面
                             }];
    
    
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                pickerview = [[UIImagePickerController alloc] init];//初始化
                                pickerview.delegate = self;
                                pickerview.allowsEditing = YES;//设置可编辑
                                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                pickerview.sourceType = sourceType;
                                [self presentViewController:pickerview animated:YES completion:nil];//进入照相界面
                            }];
    
    
    
    
    [alert addAction:camera];
    [alert addAction:photo];
    
    [self presentViewController:alert animated:YES completion:nil];
    

}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"SMILE!");
  
    
    image = [PublicCommon scaleToSize:image size:CGSizeMake(512, 512)];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData *jpgdata = UIImageJPEGRepresentation(image, 1);
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [FileCommon getCacheDirectory];
    cellimg.image = image;
    
    dispatch_async(GLOBALQ, ^{
        
        HttpFile *httpfile = [[HttpFile alloc] init:JPG];
        ReturnData * rd =  [httpfile uploadFileData:jpgdata mediaType:@"02" imageType:@"03"];
        
        
    });
    
    
    
//    NSString *uuid = [[NSUUID UUID] UUIDString];
//    
//    //    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
//    //
//    NSString *filename = [NSString stringWithFormat:@"%@.jpg",uuid];
//    [fileManager createFileAtPath:[filePath stringByAppendingString:filename] contents:jpgdata attributes:nil];
    

    
    
//    MBProgressHUD *hub=[[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:hub];
//    [hub show:YES];
//    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t mainQ = dispatch_get_main_queue();
//    dispatch_async(globalQ, ^{
//        
//        HttpServer *http = [[HttpServer alloc] init:UploadUrl];
//        ReturnData *rd =  [http uploadfile:jpgdata mediaid:uuid mediatype:@"01" filetype:@".jpg"];
//        if (rd && rd.returnCode==0)
//        {
//            http = [[HttpServer alloc] init:UpdateUserNickImg];
//            rd=   [http UpdateUserImg:uuid];
//        }
//        
//        
//        dispatch_async(mainQ, ^{
//            [hub hide:YES];
//            if (rd && rd.returnCode==0)
//            {
//                [UserInfo getInstance].nickimg =image;
//                nickimg.image =     [UserInfo getInstance].nickimg;
//                [UserInfo getInstance].picture = uuid;
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                [alert show];
//            }
//            else
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                [alert show];
//            }
//        });
//        
//    });
    
    
    
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
