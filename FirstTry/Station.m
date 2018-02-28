//
//  Station.m
//  FirstTry
//
//  Created by schooldave on 3/20/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "Station.h"

@implementation Station


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)stationWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
