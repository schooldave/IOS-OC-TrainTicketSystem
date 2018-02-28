//
//  UserInfo.h
//  FirstTry
//
//  Created by schooldave on 4/21/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *idCardNumber;
@property (nonatomic, copy) NSString *phone;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)userInfoWithDict:(NSDictionary *)dict;

@end
