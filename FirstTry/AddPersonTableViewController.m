//
//  AddPersonTableViewController.m
//  FirstTry
//
//  Created by schooldave on 4/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "AddPersonTableViewController.h"

@interface AddPersonTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *idCardNumberField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation AddPersonTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.idCardNumberField addTarget:self action: @selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.enabled = self.nameField.text.length > 0 && self.idCardNumberField.text.length > 0;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//添加按钮的点击事件
- (void)addClick
{
    NSString *insertSql = [NSString stringWithFormat:@"insert into T_PersonInfo (name, idCardNumber, username) values ('%@','%@','%@');", self.nameField.text, self.idCardNumberField.text, self.username];
    if ([[SqlTool shareinstance] insertData:insertSql]) {
        NSLog(@"成功插入信息");
    } else NSLog(@"插入失败");
    //判断代理方法是不是能够响应
    if([self.delegate respondsToSelector:@selector(addPersonTableViewController:)])
    {        
        //如果可以响应 那么执行代理方法
        [self.delegate addPersonTableViewController:self];
        //返回上一个控制器（联系人列表）
        [self.navigationController popViewControllerAnimated:YES];
    }

    
}

//文本框文本发生变化时调用
- (void)textChange
{
    self.addButton.enabled = self.nameField.text.length > 0 && self.idCardNumberField.text.length > 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
