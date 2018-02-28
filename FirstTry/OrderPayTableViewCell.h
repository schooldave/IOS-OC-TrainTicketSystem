//
//  OrderPayTableViewCell.h
//  FirstTry
//
//  Created by schooldave on 4/15/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
#import "TicketInfo.h"
@interface OrderPayTableViewCell : UITableViewCell

@property (strong, nonatomic) OrderInfo *orderInfo;
@property (strong, nonatomic) TicketInfo *ticketInfo;

@end
