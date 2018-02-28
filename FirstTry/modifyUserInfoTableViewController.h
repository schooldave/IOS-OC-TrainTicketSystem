//
//  modifyUserInfoTableViewController.h
//  FirstTry
//
//  Created by schooldave on 3/6/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlTool.h"
#import "SVProgressHUD.h"

@interface modifyUserInfoTableViewController : UITableViewController

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;


@end
