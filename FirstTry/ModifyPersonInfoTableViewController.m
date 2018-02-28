//
//  ModifyPersonInfoTableViewController.m
//  FirstTry
//
//  Created by schooldave on 4/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "ModifyPersonInfoTableViewController.h"
#import "SVProgressHUD.h"

@interface ModifyPersonInfoTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *idCardNumberField;
@property (weak, nonatomic) IBOutlet UIButton *modifyButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *modifyTableViewCell;
@end

@implementation ModifyPersonInfoTableViewController
- (IBAction)editButton:(UIBarButtonItem *)sender {
    if (self.modifyTableViewCell.hidden) {
        sender.title = @"取消";
        self.nameField.enabled = YES;
        self.idCardNumberField.enabled = YES;
        self.modifyTableViewCell.hidden = NO;
    } else {
        sender.title = @"编辑";
        self.nameField.enabled = NO;
        self.idCardNumberField.enabled = NO;
        self.modifyTableViewCell.hidden = YES;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.idCardNumberField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.modifyButton addTarget:self action:@selector(modifyPerson) forControlEvents:UIControlEventTouchUpInside];
    self.modifyButton.enabled = self.nameField.text.length > 0 && self.idCardNumberField.text.length > 0;
    
    self.nameField.text = self.name;
    NSLog(@"%@",self.name);
    self.idCardNumberField.text = self.idCardNumber;
    self.nameField.enabled = NO;
    self.idCardNumberField.enabled = NO;
    self.modifyTableViewCell.hidden = YES;

    
    
}

- (void)textChange
{
    self.modifyButton.enabled = self.nameField.text.length > 0 && self.idCardNumberField.text.length > 0;
}

- (void)modifyPerson
{
    NSString *modifySql = [NSString stringWithFormat:@"update 'T_PersonInfo' set name = '%@',idCardNumber = '%@' where idCardNumber = '%@' and username = '%@'",self.nameField.text, self.idCardNumberField.text, self.idCardNumber, self.username];
    if(self.nameField.text.length > 0 && self.idCardNumberField.text > 0)
    {
        [[SqlTool shareinstance] modifyData:modifySql];
        [SVProgressHUD showSuccessWithStatus:@"信息更新成功"];
        [SVProgressHUD dismissWithDelay:1];
        if ([self.delegate respondsToSelector:@selector(modifyPersonInfoTableViewController:)]){
            [self.delegate modifyPersonInfoTableViewController:self];
        }
        [self.navigationController popViewControllerAnimated:YES];

    } else {
        [SVProgressHUD showErrorWithStatus:@"请输入完整信息!"];
        [SVProgressHUD dismissWithDelay:1];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
      // Dispose of any resources that can be recreated.
}

@end
