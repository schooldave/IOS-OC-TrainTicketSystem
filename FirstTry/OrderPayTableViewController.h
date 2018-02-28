//
//  OrderPayTableViewController.h
//  FirstTry
//
//  Created by schooldave on 4/15/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketInfo.h"

@interface OrderPayTableViewController : UITableViewController


@property (nonatomic, strong) TicketInfo *ticketInfoTrans;
@property (nonatomic, strong) NSArray *passengerInfoTrans;
@property (nonatomic, strong) NSArray *orderNumberInfoTrans;
@property (nonatomic, strong) NSString *username;


@end
