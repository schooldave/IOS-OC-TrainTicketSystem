//
//  PaymentChoiceTableViewController.h
//  FirstTry
//
//  Created by schooldave on 4/19/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketInfo.h"

@interface PaymentChoiceTableViewController : UITableViewController

@property (copy, nonatomic) NSString *username;
@property (nonatomic, strong) NSArray *orderNumberInfoTrans;
@property (nonatomic, strong) TicketInfo *ticketInfoTrans;
@end
