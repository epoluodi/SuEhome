//
//  T_Member+CoreDataProperties.m
//  SuEhome
//
//  Created by Stereo on 2016/11/29.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "T_Member+CoreDataProperties.h"

@implementation T_Member (CoreDataProperties)

+ (NSFetchRequest<T_Member *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"T_Member"];
}

@dynamic dept_id;
@dynamic fpy;
@dynamic gender;
@dynamic nick_name;
@dynamic org_id;
@dynamic phone;
@dynamic pic_id;
@dynamic py;
@dynamic user_id;
@dynamic user_name;

@end
