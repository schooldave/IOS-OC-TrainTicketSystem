//
//  AddPassengerTableViewController.h
//  FirstTry
//
//  Created by schooldave on 4/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlTool.h"
#import "AddPersonTableViewController.h"

@class AddPassengerTableViewController;

@protocol addPassengerTableViewControllerDelegate <NSObject>

@optional

- (void)addPassengerTableViewController: (AddPassengerTableViewController *)addPassengerTableViewController andPassenger: (NSArray *)passenger;

@end

@interface AddPassengerTableViewController : UITableViewController

@property (nonatomic, copy) NSString *username;

@property (weak, nonatomic) id<addPassengerTableViewControllerDelegate> delegate;

@end
