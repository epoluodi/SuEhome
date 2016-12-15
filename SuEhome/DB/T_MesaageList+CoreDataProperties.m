//
//  T_MesaageList+CoreDataProperties.m
//  SuEhome
//
//  Created by Stereo on 2016/12/15.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "T_MesaageList+CoreDataProperties.h"

@implementation T_MesaageList (CoreDataProperties)

+ (NSFetchRequest<T_MesaageList *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"T_MesaageList"];
}

@dynamic msgid;
@dynamic msgtype;
@dynamic msgtitle;
@dynamic msgcontent;
@dynamic msgmark;
@dynamic msgdate;
@dynamic senderid;
@dynamic istop;
@dynamic isdisturb;

@end
