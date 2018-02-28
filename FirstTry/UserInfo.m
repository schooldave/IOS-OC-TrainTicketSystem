//
//  UserInfo.m
//  FirstTry
//
//  Created by schooldave on 4/21/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)userInfoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
