//
//  modifyUserInfoTableViewController.m
//  FirstTry
//
//  Created by schooldave on 3/6/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "modifyUserInfoTableViewController.h"

@interface modifyUserInfoTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *idCardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;


@end

@implementation modifyUserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)modifyBarButton:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定更改?" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction* modifyAction = [UIAlertAction actionWithTitle:@"更新信息" style:UIAlertActionStyleDestructive
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
    
    NSString *modifySql = [NSString stringWithFormat:@"update 'T_UserInfo' set name = '%@',idCardNumber = '%@', phone = '%@' where username = '%@'",self.nameField.text,self.idCardNumberField.text,self.phoneField.text,self.username];

    BOOL isEmpty = self.passwordField.text.length > 0 && self.nameField.text.length >0 && self.idCardNumberField.text > 0 && self.phoneField.text.length > 0;
    
    if (isEmpty) {
        
        if ([self.passwordField.text isEqualToString:self.password]) {
            [[SqlTool shareinstance] modifyData:modifySql];
            [SVProgressHUD showSuccessWithStatus:@"信息更新成功"];
            [SVProgressHUD dismissWithDelay:1];

        } else {
            [SVProgressHUD showErrorWithStatus:@"密码错误，更新失败"];
            [SVProgressHUD dismissWithDelay:1];
        }

    } else {
        
        [SVProgressHUD showErrorWithStatus:@"请输入完整信息!"];
        [SVProgressHUD dismissWithDelay:1];
        
    }
    
    
    
    
 
}



@end
