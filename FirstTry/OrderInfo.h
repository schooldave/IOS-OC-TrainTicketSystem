//
//  OrderInfo.h
//  FirstTry
//
//  Created by schooldave on 4/16/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfo : NSObject
//@property (nonatomic, copy) NSString *orderNumber;
@property (nonatomic, copy) NSString *orderNumber;
@property (nonatomic, copy) NSString *trainNumber;
@property (nonatomic, copy) NSString *startStation;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *arriveStation;
@property (nonatomic, copy) NSString *arriveTime;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *idCardNumber;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSString *seatClass;
@property (nonatomic, copy) NSString *paymentState;
@property (nonatomic, copy) NSString *date;

- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)orderInfoWithDict: (NSDictionary *)dict;

@end
