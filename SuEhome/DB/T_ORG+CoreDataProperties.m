//
//  T_ORG+CoreDataProperties.m
//  SuEhome
//
//  Created by Stereo on 2016/11/29.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "T_ORG+CoreDataProperties.h"

@implementation T_ORG (CoreDataProperties)

+ (NSFetchRequest<T_ORG *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"T_ORG"];
}

@dynamic disp_sn;
@dynamic org_id;
@dynamic org_name;
@dynamic p_org_id;
@dynamic py;

@end
