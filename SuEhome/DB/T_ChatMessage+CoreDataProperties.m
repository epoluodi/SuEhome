//
//  T_ChatMessage+CoreDataProperties.m
//  SuEhome
//
//  Created by Stereo on 2016/12/9.
//  Copyright © 2016年 Suypower. All rights reserved.
//

#import "T_ChatMessage+CoreDataProperties.h"

@implementation T_ChatMessage (CoreDataProperties)

+ (NSFetchRequest<T_ChatMessage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"T_ChatMessage"];
}

@dynamic groupid;
@dynamic content;
@dynamic isself;
@dynamic msgsendstate;
@dynamic sender;
@dynamic senderid;
@dynamic msgdate;
@dynamic msgType;
@dynamic msgid;
@dynamic createdt;

@end
