//
//  LoginViewController.m
//  FirstTry
//
//  Created by schooldave on 3/2/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "LoginViewController.h"
#import "userInfoTableViewController.h"
#import "TicketMainTableViewController.h"
#import "OrderPresentTableViewController.h"
#import "SVProgressHUD.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;


@end
//
//void (^searchBlock)() = ^void(){
//    
//};


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.usernameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.createAccountButton addTarget:self action:@selector(createAccount) forControlEvents:UIControlEventTouchUpInside];

    
 
    
    // Do any additional setup after loading the view.
}



-(void)createAccount
{
    [self performSegueWithIdentifier:@"createNewAccount" sender:nil];
}

//T_UserInfo 属性：username, password, name, idCardNumber, phone
//登陆按钮的点击事件
- (void)login
{
    
    NSString *searchSql = [NSString stringWithFormat:@"select username, password, name, idCardNumber, phone from T_UserInfo where username = '%@'",self.usernameField.text];
    NSArray *userDataArray = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:0];


        //第三方框架
        [SVProgressHUD showWithStatus:@"正在登录"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            //当用户名和密码正确的时候 进行跳转
            if (userDataArray.count == 1) {
                NSLog(@"Find the user");
                NSLog(@"%@",[userDataArray firstObject][@"username"]);
                
                if ([self.usernameField.text isEqualToString:[userDataArray firstObject][@"username"]] && [self.passwordField.text isEqualToString:[userDataArray firstObject][@"password"]] && ![self.usernameField.text isEqualToString:@"admin"]) {
                    //跳!!!
                    [self performSegueWithIdentifier:@"loginToMainView" sender:nil];
                    
                } else if([self.usernameField.text isEqualToString:[userDataArray firstObject][@"username"]] && [self.passwordField.text isEqualToString:[userDataArray firstObject][@"password"]] && [self.usernameField.text isEqualToString:@"admin"])
                {
                    [self performSegueWithIdentifier:@"loginToAdminView" sender:nil];
                } else{
                    //提示错误
                    [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
                    [SVProgressHUD dismissWithDelay:1];
                }
                
                
            } else {
                [SVProgressHUD showErrorWithStatus:@"用户不存在"];
                [SVProgressHUD dismissWithDelay:1];
                NSLog(@"User does not exist");
            }
            
      
        });

    
    
}

//文本框内容发生改变的时候调用
- (void)textChange
{
    NSLog(@"%@",self.usernameField.text);
    NSLog(@"%@",self.passwordField.text);
    self.loginButton.enabled = self.usernameField.text.length > 0 && self.passwordField.text.length > 0;
    
}



//实现该方法 view需要是继承UIControl而来的
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//只要走Storyboard都会调用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //通过Segue 将登陆界面的对象传给用户信息界面
    
    //将数据传到userInfoTableViewController
    if ([segue.identifier isEqualToString:@"loginToMainView"]) {
        UITabBarController *tabBarController = segue.destinationViewController;
        //将tarBarController所拥有的viewControllers赋值到Array中
        NSArray *controllerArray= tabBarController.viewControllers;
        //将array中的第三个viewController拿到
        UINavigationController *current2 = [controllerArray objectAtIndex:2];
        //将当前的viewController指向的tableView
        userInfoTableViewController *userInfoView = (userInfoTableViewController *)current2.topViewController;
        userInfoView.navigationItem.title = self.usernameField.text;
        userInfoView.username = self.usernameField.text;
        
        //
        UINavigationController *current0 = [controllerArray objectAtIndex:0];
        TicketMainTableViewController *ticketMainTableView = (TicketMainTableViewController *)current0.topViewController;
        ticketMainTableView.username = self.usernameField.text;
//        [ticketMainTableView.dateSelectedButton setTitle:[self getDate] forState:UIControlStateNormal];
        
        UINavigationController *current1 = [controllerArray objectAtIndex:1];
        OrderPresentTableViewController *orderPresent = (OrderPresentTableViewController *)current1.topViewController;
        orderPresent.username = self.usernameField.text;
        
        
    } else if ([segue.identifier isEqualToString:@"createNewAccount"]) {
        //        UINavigationController *navigationController = segue.destinationViewController;
        
    }
    
    
}

- (NSString *)getDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSDate * currenDate=[NSDate date];
    return  [formatter stringFromDate:currenDate];
    
}

@end
