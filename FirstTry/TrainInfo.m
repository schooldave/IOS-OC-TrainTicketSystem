//
//  TrainInfo.m
//  CellExpand
//
//  Created by schooldave on 3/25/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "TrainInfo.h"

@implementation TrainInfo

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)trainInfoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
