//
//  modifyPasswordTableViewController.m
//  FirstTry
//
//  Created by schooldave on 3/7/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "modifyPasswordTableViewController.h"

NSString * getPassword;

@interface modifyPasswordTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *newpsd1Field;
@property (weak, nonatomic) IBOutlet UITextField *newpsd2Field;

@end

@implementation modifyPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSString *searchSql = [NSString stringWithFormat:@"select username, password, name, idCardNumber, phone from T_UserInfo where username = '%@'",self.username];
    NSArray *userDataArray = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:0];
    getPassword = [userDataArray firstObject][@"password"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)modifyPassword:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定更改?" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction* modifyAction = [UIAlertAction actionWithTitle:@"更新密码" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action ) {
                                                             NSLog(@"hahaha");
                                                             [self modifyInfo];
                                                         }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action ) {}];
    [alert addAction:modifyAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}

- (void)modifyInfo {

    NSString *modifySql = [NSString stringWithFormat:@"update 'T_UserInfo' set password = '%@' where username = '%@'",self.newpsd1Field.text,self.username];
    
    BOOL isEmpty = self.oldPasswordField.text.length > 0 && self.newpsd1Field.text.length > 0 && self.newpsd2Field.text.length > 0;
    
    if (isEmpty) {
        
        if ([self.oldPasswordField.text isEqualToString:getPassword]) {
            [[SqlTool shareinstance] modifyData:modifySql];
            [SVProgressHUD showSuccessWithStatus:@"密码更新成功"];
            [SVProgressHUD dismissWithDelay:1];
            self.oldPasswordField.text = nil;
            self.newpsd1Field.text = nil;
            self.newpsd2Field.text = nil;
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"旧密码错误，更新失败"];
            [SVProgressHUD dismissWithDelay:1];
        }
        
    } else {
        
        [SVProgressHUD showErrorWithStatus:@"请输入完整信息!"];
        [SVProgressHUD dismissWithDelay:1];
        
    }
    
}


@end
