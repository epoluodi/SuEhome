//
//  T_ChatMessage+CoreDataProperties.h
//  SuEhome
//
//  Created by Stereo on 2016/12/9.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "T_ChatMessage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface T_ChatMessage (CoreDataProperties)

+ (NSFetchRequest<T_ChatMessage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *groupid;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSNumber *isself;
@property (nullable, nonatomic, copy) NSNumber *msgsendstate;
@property (nullable, nonatomic, copy) NSString *sender;
@property (nullable, nonatomic, copy) NSString *senderid;
@property (nullable, nonatomic, copy) NSString *msgdate;
@property (nullable, nonatomic, copy) NSNumber *msgType;
@property (nullable, nonatomic, copy) NSString *msgid;
@property (nullable, nonatomic, copy) NSString *createdt;

@end

NS_ASSUME_NONNULL_END
