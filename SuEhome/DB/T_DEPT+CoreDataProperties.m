//
//  T_DEPT+CoreDataProperties.m
//  SuEhome
//
//  Created by Stereo on 2016/11/29.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "T_DEPT+CoreDataProperties.h"

@implementation T_DEPT (CoreDataProperties)

+ (NSFetchRequest<T_DEPT *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"T_DEPT"];
}

@dynamic dept_id;
@dynamic dept_name;
@dynamic disp_sn;
@dynamic org_id;
@dynamic p_dept_id;
@dynamic py;

@end
