//
//  T_MesaageList+CoreDataProperties.h
//  SuEhome
//
//  Created by Stereo on 2016/12/15.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "T_MesaageList+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface T_MesaageList (CoreDataProperties)

+ (NSFetchRequest<T_MesaageList *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *msgid;
@property (nullable, nonatomic, copy) NSNumber *msgtype;
@property (nullable, nonatomic, copy) NSString *msgtitle;
@property (nullable, nonatomic, copy) NSString *msgcontent;
@property (nullable, nonatomic, copy) NSNumber *msgmark;
@property (nullable, nonatomic, copy) NSString *msgdate;
@property (nullable, nonatomic, copy) NSString *senderid;
@property (nullable, nonatomic, copy) NSNumber *istop;
@property (nullable, nonatomic, copy) NSNumber *isdisturb;

@end

NS_ASSUME_NONNULL_END
