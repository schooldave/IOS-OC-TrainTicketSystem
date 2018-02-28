//
//  TicketMainTableViewController.h
//  FirstTry
//
//  Created by schooldave on 3/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateSelectedViewController.h"
#import "CitySearchViewController.h"

@interface TicketMainTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *dateSelectedButton;
@property (nonatomic ,copy) NSString *username;

@end
