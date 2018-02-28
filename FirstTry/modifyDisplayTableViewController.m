//
//  modifyDisplayTableViewController.m
//  FirstTry
//
//  Created by schooldave on 3/6/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "modifyDisplayTableViewController.h"

NSString *passwordGet;

@interface modifyDisplayTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *idCardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@end

@implementation modifyDisplayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *searchSql = [NSString stringWithFormat:@"select username, password, name, idCardNumber, phone from T_UserInfo where username = '%@'",self.username];
    NSArray *userDataArray = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:0];
    
    NSLog(@"%@",[userDataArray firstObject][@"username"]);
    
    self.usernameField.text = [userDataArray firstObject][@"username"];
    self.nameField.text = [userDataArray firstObject][@"name"];
    self.idCardNumberField.text = [userDataArray firstObject][@"idCardNumber"];
    self.phoneField.text = [userDataArray firstObject][@"phone"];
    passwordGet = [userDataArray firstObject][@"password"];
}

-(void)viewDidAppear:(BOOL)animated{
    [self viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    modifyUserInfoTableViewController *modifyUserInfo = segue.destinationViewController;
    modifyUserInfo.username = self.username;
    modifyUserInfo.password = passwordGet;
    
    
}


@end
