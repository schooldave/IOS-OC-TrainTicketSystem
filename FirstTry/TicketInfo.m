//
//  TicketInfo.m
//  CellExpand
//
//  Created by schooldave on 3/22/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "TicketInfo.h"


@implementation TicketInfo


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)ticketInfoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
