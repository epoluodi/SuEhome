//
//  T_Member+CoreDataProperties.h
//  SuEhome
//
//  Created by Stereo on 2016/11/29.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "T_Member+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface T_Member (CoreDataProperties)

+ (NSFetchRequest<T_Member *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *dept_id;
@property (nullable, nonatomic, copy) NSString *fpy;
@property (nullable, nonatomic, copy) NSNumber *gender;
@property (nullable, nonatomic, copy) NSString *nick_name;
@property (nullable, nonatomic, copy) NSString *org_id;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *pic_id;
@property (nullable, nonatomic, copy) NSString *py;
@property (nullable, nonatomic, copy) NSString *user_id;
@property (nullable, nonatomic, copy) NSString *user_name;

@end

NS_ASSUME_NONNULL_END
