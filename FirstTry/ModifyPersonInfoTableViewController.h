//
//  ModifyPersonInfoTableViewController.h
//  FirstTry
//
//  Created by schooldave on 4/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlTool.h"

@class ModifyPersonInfoTableViewController;
@protocol modifyPersonInfoTableViewControllerDelegate <NSObject>

@optional
- (void)modifyPersonInfoTableViewController:(ModifyPersonInfoTableViewController *)modifyPersonInfoTableView;

@end


@interface ModifyPersonInfoTableViewController : UITableViewController


@property (nonatomic, copy) NSString *idCardNumber;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *username;

@property (nonatomic, weak) id<modifyPersonInfoTableViewControllerDelegate> delegate;
@end
