//
//  TicketInfo.h
//  CellExpand
//
//  Created by schooldave on 3/22/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketInfo : NSObject

@property (nonatomic, copy) NSString *trainNumber;
@property (nonatomic, copy) NSString *startStation;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *arriveStation;
@property (nonatomic, copy) NSString *arriveTime;
@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSNumber *businessPrice;
@property (nonatomic, copy) NSNumber *firstPrice;
@property (nonatomic, copy) NSNumber *secondPrice;

@property (nonatomic, copy) NSNumber *businessCount;
@property (nonatomic, copy) NSNumber *firstCount;
@property (nonatomic, copy) NSNumber *secondCount;

@property (nonatomic, copy) NSString *date;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ticketInfoWithDict:(NSDictionary *)dict;
@end
