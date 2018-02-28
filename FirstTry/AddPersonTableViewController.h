//
//  AddPersonTableViewController.h
//  FirstTry
//
//  Created by schooldave on 4/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlTool.h"

@class AddPersonTableViewController;

@protocol addPersonTableViewControllerDelegate <NSObject>

@optional

- (void)addPersonTableViewController: (AddPersonTableViewController *)addPersonTableViewController;

@end

@interface AddPersonTableViewController : UITableViewController

@property (nonatomic ,copy) NSString *username;

@property (nonatomic, weak) id<addPersonTableViewControllerDelegate> delegate;

@end
