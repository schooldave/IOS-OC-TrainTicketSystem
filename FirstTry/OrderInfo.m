//
//  OrderInfo.m
//  FirstTry
//
//  Created by schooldave on 4/16/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "OrderInfo.h"

@implementation OrderInfo

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)orderInfoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}




@end
