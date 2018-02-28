//
//  PersonInfoTableViewController.h
//  FirstTry
//
//  Created by schooldave on 4/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlTool.h"
#import "AddPersonTableViewController.h"
#import "ModifyPersonInfoTableViewController.h"

@interface PersonInfoTableViewController : UITableViewController

@property (nonatomic, copy) NSString *username;
@end
