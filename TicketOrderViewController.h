//
//  TicketOrderViewController.h
//  FirstTry
//
//  Created by schooldave on 4/4/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketInfo.h"
#import "TicketOrderConfrimTableViewCell.h"
#import "AddPassengerTableViewController.h"

@interface TicketOrderViewController : UIViewController

@property (nonatomic, strong) TicketInfo *ticketInfoTrans;
@property (nonatomic, copy) NSMutableArray *transferLeftArray;
@property (nonatomic, copy) NSString *dateConfirm;
@property (nonatomic, copy) NSString *username;

@end
