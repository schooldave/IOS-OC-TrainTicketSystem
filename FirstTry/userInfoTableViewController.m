//
//  userInfoTableViewController.m
//  FirstTry
//
//  Created by schooldave on 3/2/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "userInfoTableViewController.h"

NSString *passwordForTransport;

@interface userInfoTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;





@end

@implementation userInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.logOutButton addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%@",self.username);
    NSLog(@"-----%@========",self.navigationItem.title);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    //通过Segue 将登陆界面的对象传给用户信息界面
    
//     toModifyDisplay
    if ([segue.identifier isEqualToString:@"toModifyDisplay"]) {
        modifyDisplayTableViewController *modifyDisplay = segue.destinationViewController;
        modifyDisplay.username = self.username;
        NSLog(@"SEgue------------%@",self.username);
    } else if( [segue.identifier isEqualToString:@"toModifyPasswordDisplay"]) {
        
        modifyPasswordTableViewController *modifyPassword = segue.destinationViewController;
        modifyPassword.username = self.username;
        
    } else if ( [segue.identifier isEqualToString:@"toPersonInfoDisplay"]) {
        PersonInfoTableViewController *personInfo = segue.destinationViewController;
        personInfo.username = self.username;
    }
}



- (void)logOut
{
    //设置注销Alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要注销?" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction* logOutAction = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action ) {
                                                             NSLog(@"hahaha");
                                                             //返回主界面
                                                             [self performSegueWithIdentifier:@"logOutToMainMenu" sender:nil];

                                                         }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action ) {}];
    [alert addAction:logOutAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


@end
