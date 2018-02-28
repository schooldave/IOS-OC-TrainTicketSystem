//
//  PaymentChoiceTableViewController.m
//  FirstTry
//
//  Created by schooldave on 4/19/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "PaymentChoiceTableViewController.h"
#import "SVProgressHUD.h"
#import "OrderPresentTableViewController.h"
#import "userInfoTableViewController.h"
#import "TicketMainTableViewController.h"

@interface PaymentChoiceTableViewController ()

@end

@implementation PaymentChoiceTableViewController


- (IBAction)payButton:(id)sender {

    [SVProgressHUD showWithStatus:@"正在处理中"];
    [SVProgressHUD dismissWithDelay:2];
//
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
        [SVProgressHUD dismissWithDelay:1];
        
    });
    NSUInteger count = self.orderNumberInfoTrans.count;
    while (count--) {
        NSString *modifySqlForOrder = [NSString stringWithFormat:@"update T_OrderInfo set paymentState = '%@' where orderNumber = '%@'",@"YES",self.orderNumberInfoTrans[count]];
        [[SqlTool shareinstance] modifyData:modifySqlForOrder];
        
//        
//        NSString *searchSql = [NSString stringWithFormat:@"select orderNumber,trainNumber,startStation,startTime,arriveStation,arriveTime,duration,idCardNumber,name,username,price,seatClass, paymentState,date from T_OrderInfo where orderNumber = '%@'", self.orderNumberInfoTrans[count]];
//        NSMutableArray *resultArrayDict = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:4];
//        NSString *seatClass = resultArrayDict[0][@"seatClass"];
//        NSLog(@"1234154ffffffff %@",seatClass);
//        NSString *updateClas;
//        NSNumber *count;
//        if ([seatClass isEqualToString:@"businessPrice"]) {
//            updateClas = @"businessCount";
//            count = self.ticketInfoTrans.businessCount;
//        } else if ([seatClass isEqualToString:@"firstPrice"]) {
//            updateClas = @"firstCount";
//            count = self.ticketInfoTrans.firstCount;
//        } else {
//            updateClas = @"secondCount";
//            count = self.ticketInfoTrans.secondCount;
//        }
//        NSString *modifySqlForTicket = [NSString stringWithFormat:@"update T_TicketInfo set '%@' = '%@' where trainNumber = '%@' and startStation = '%@' and arriveStation = '%@' and date = '%@'", seatClass,count, self.ticketInfoTrans.trainNumber, self.ticketInfoTrans.startStation, self.ticketInfoTrans.arriveStation, self.ticketInfoTrans.date];
//        [[SqlTool shareinstance] modifyData:modifySqlForTicket];
        
    }
    
  //          [self performSegueWithIdentifier:@"toOrderInsure" sender:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        [self performSegueWithIdentifier:@"toOrderPresent" sender:nil];
    
    });


}
//
//- (IBAction)payLatterButton:(id)sender {
//    
//    [self performSegueWithIdentifier:@"" sender:nil];
//}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toOrderPresent"]) {
        UITabBarController *tabBarController = segue.destinationViewController;
        tabBarController.selectedIndex = 1;
        //将tarBarController所拥有的viewControllers赋值到Array中
        NSArray *controllerArray= tabBarController.viewControllers;
        //将array中的第三个viewController拿到
        UINavigationController *current2 = [controllerArray objectAtIndex:2];
        //将当前的viewController指向的tableView
        userInfoTableViewController *userInfoView = (userInfoTableViewController *)current2.topViewController;
        userInfoView.navigationItem.title = self.username;
        userInfoView.username = self.username;
        
        //
        UINavigationController *current0 = [controllerArray objectAtIndex:0];
        TicketMainTableViewController *ticketMainTableView = (TicketMainTableViewController *)current0.topViewController;
        ticketMainTableView.username = self.username;
        
        UINavigationController *current1 = [controllerArray objectAtIndex:1];
        OrderPresentTableViewController *orderPresent = (OrderPresentTableViewController *)current1.topViewController;
        orderPresent.username = self.username;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
