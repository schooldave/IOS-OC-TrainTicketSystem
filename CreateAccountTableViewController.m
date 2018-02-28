//
//  CreateAccountTableViewController.m
//  FirstTry
//
//  Created by schooldave on 3/5/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "CreateAccountTableViewController.h"

sqlite3 *database;

@interface CreateAccountTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField<UITextFieldDelegate> *usernameField;
@property (weak, nonatomic) IBOutlet UITextField<UITextFieldDelegate> *passwordFieldFirst;
@property (weak, nonatomic) IBOutlet UITextField *passwordFieldSecond;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *idCardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation CreateAccountTableViewController


//T_UserInfo 属性：username, password, name, idCardNumber, phone, ticketCount

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.signUpButton addTarget:self action:@selector(insertNewUser) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)insertNewUser
{
    BOOL isFieldEmpty = self.usernameField.text.length > 0 && self.nameField.text.length > 0 && self.passwordFieldFirst.text.length > 0 && self.passwordFieldSecond.text.length > 0 && self.idCardNumberField.text.length > 0 && self.phoneField.text.length > 0;
    
    if (isFieldEmpty) {
        if ([self.passwordFieldFirst.text isEqualToString:self.passwordFieldSecond.text]) {
            
            NSString *insertSql = [NSString stringWithFormat:@"insert into T_UserInfo(username,password,name,idCardNumber,phone) values('%@', '%@', '%@', '%@','%@');",self.usernameField.text,self.passwordFieldFirst.text,self.nameField.text,self.idCardNumberField.text,self.phoneField.text];
            
            if ([[SqlTool shareinstance] insertData:insertSql]) {
                
                [SVProgressHUD showSuccessWithStatus:@"😊注册成功😊"];
                
                [SVProgressHUD dismissWithDelay:1];
                NSLog(@"插入成功");
            } else {

                [SVProgressHUD showErrorWithStatus:@"😅换个用户名试试😂"];
                [SVProgressHUD dismissWithDelay:1];
                NSLog(@"插入失败");
            }
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"🤔两次输入的密码不一致🤔"];
            [SVProgressHUD dismissWithDelay:1];
            NSLog(@"%@",self.passwordFieldFirst.text);
            NSLog(@"%@",self.passwordFieldSecond.text);
            NSLog(@"The second password is not compatible with the first one!!");
        }

    } else {
        [SVProgressHUD showErrorWithStatus:@"😔请完成未完成的信息😔"];
        [SVProgressHUD dismissWithDelay:1.5];
        NSLog(@"请完成未完成的信息");
    }
    
}



////UITextFieldDelegate代理 改变第一响应者
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (textField == self.usernameField) {
//        [self.passwordFieldFirst becomeFirstResponder];
//    } else if (textField == self.passwordFieldFirst){
//        [self.passwordFieldSecond becomeFirstResponder];
//    } else if (textField == self.passwordFieldSecond){
//        [self.nameField becomeFirstResponder];
//    } else if (textField == self.nameField){
//        [self.idCardNumberField becomeFirstResponder];
//    } else if (textField == self.idCardNumberField){
//        [self.phoneField becomeFirstResponder];
//    } else {
//        [self.tableView endEditing:YES];
//    }
//  
//    return YES;
//}

@end
