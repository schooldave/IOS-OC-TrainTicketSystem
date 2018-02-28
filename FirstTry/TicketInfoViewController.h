//
//  TicketInfoViewController.h
//  FirstTry
//
//  Created by schooldave on 3/26/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlTool.h"
#import "TicketInfo.h"
#import "TicketInfoCell.h"
#import "TrainInfo.h"
#import "TrainInfoCell.h"
#import "TicketOrderViewController.h"

@class TicketInfoViewController;
@protocol TicketInfoViewControllerDelegate <NSObject>

@optional

- (void)ticketInfoViewController: (TicketInfoViewController *)ticketInfoViewController withDate: (NSString *)date;

@end




@interface TicketInfoViewController : UIViewController

@property (nonatomic, copy) NSString *startStation;
@property (nonatomic, copy) NSString *arriveStation;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *username;

@property (nonatomic, weak) id<TicketInfoViewControllerDelegate>delegate;

@end
