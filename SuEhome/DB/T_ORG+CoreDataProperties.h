//
//  T_ORG+CoreDataProperties.h
//  SuEhome
//
//  Created by Stereo on 2016/11/29.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "T_ORG+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface T_ORG (CoreDataProperties)

+ (NSFetchRequest<T_ORG *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *disp_sn;
@property (nullable, nonatomic, copy) NSString *org_id;
@property (nullable, nonatomic, copy) NSString *org_name;
@property (nullable, nonatomic, copy) NSString *p_org_id;
@property (nullable, nonatomic, copy) NSString *py;

@end

NS_ASSUME_NONNULL_END
