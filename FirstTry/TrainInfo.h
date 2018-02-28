//
//  TrainInfo.h
//  CellExpand
//
//  Created by schooldave on 3/25/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainInfo : NSObject

@property (nonatomic, copy) NSString *station;
@property (nonatomic, copy) NSString *trainNumber;
@property (nonatomic, copy) NSString *arriveTime;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSNumber *stationOrder;
@property (nonatomic, copy) NSNumber *totalNumber;


- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)trainInfoWithDict: (NSDictionary *)dict;

@end
