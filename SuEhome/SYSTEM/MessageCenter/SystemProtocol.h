//
//  SystemProtocol.h
//  SuEhome
//
//  Created by Stereo on 2016/12/14.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "BaseProtocol.h"



@interface SystemProtocol : BaseProtocol


@property (weak,nonatomic)NSNumber * sendtime;          //发送时间
@property (weak,nonatomic)NSString * noticeId;          //通知id


@end
