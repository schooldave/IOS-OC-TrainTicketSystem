//
//  Station.h
//  FirstTry
//
//  Created by schooldave on 3/20/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject

@property(nonatomic, strong) NSArray *station;
@property(nonatomic, copy) NSString *title;


- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)stationWithDict: (NSDictionary *)dict;


@end
