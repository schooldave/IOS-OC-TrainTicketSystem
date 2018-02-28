//
//  OrderPayTableViewController.m
//  FirstTry
//
//  Created by schooldave on 4/15/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "OrderPayTableViewController.h"
#import "SqlTool.h"
#import "OrderInfo.h"
#import "OrderPayTableViewCell.h"
#import "PaymentChoiceTableViewController.h"

@interface OrderPayTableViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) NSArray *allOrderInfo;

@end

@implementation OrderPayTableViewController

- (NSArray *)allOrderInfo
{
    NSUInteger count = self.orderNumberInfoTrans.count;
//    if (_allOrderInfo == nil) {
    NSMutableArray *resultArrayDict = [NSMutableArray array];
    while ( count-- ) {
//        NSString *searchSql = [NSString stringWithFormat:@"select orderNumber,trainNumber,startStation,startTime,arriveStation,arriveTime,duration,idCardNumber,name,username,price,seatClass, paymentState,date from T_OrderInfo where startStation = '%@' AND arriveStation = '%@' AND date = '%@'", self.ticketInfoTrans.startStation,self.ticketInfoTrans.arriveStation,self.ticketInfoTrans.date];
        
    NSString *searchSql = [NSString stringWithFormat:@"select orderNumber,trainNumber,startStation,startTime,arriveStation,arriveTime,duration,idCardNumber,name,username,price,seatClass, paymentState,date from T_OrderInfo where orderNumber = '%@'", self.orderNumberInfoTrans[count]];
        [resultArrayDict addObjectsFromArray:[[SqlTool shareinstance] searchData:searchSql andChooseTableNum:4]];
    }
    NSLog(@"find %lu",(unsigned long)resultArrayDict.count);
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in resultArrayDict) {
        OrderInfo *model = [OrderInfo orderInfoWithDict:dict];
        [arrayModels addObject: model];
    }
    _allOrderInfo = arrayModels;
//    }
    return _allOrderInfo;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return [NSString stringWithFormat:@"乘车日期: %@",self.ticketInfoTrans.date];
//    } else if (section == 2) {
//        
//    }
//    return nil;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        // create the parent view that will hold header Label
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 30.0)];
        // create the button object
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        headerLabel.backgroundColor = [UIColor grayColor];
        headerLabel.opaque = NO;
        headerLabel.textColor = [UIColor blackColor];
        headerLabel.highlightedTextColor = [UIColor whiteColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:15];
        headerLabel.frame = CGRectMake(20.0, 0.0, 300.0, 30.0);
        
        // If you want to align the header text as centered
        // headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
        headerLabel.text = [NSString stringWithFormat:@"乘车日期:        %@",self.ticketInfoTrans.date];
//        [customView addSubview:headerLabel];
        [customView addSubview:headerLabel];
        return customView;
        
    }  else  return nil;
   

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 30.0)];
        // create the button object
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.opaque = NO;
        headerLabel.textColor = [UIColor blackColor];
        headerLabel.highlightedTextColor = [UIColor whiteColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:15];
        headerLabel.frame = CGRectMake(20.0, 0.0, 300.0, 30.0);
        
        // If you want to align the header text as centered
        // headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
        NSUInteger count = self.allOrderInfo.count;
        double sum = 0;
        OrderInfo *orderModel;
        //        NSLog(@"%@",orderModel.price);
        while ( count--) {
            orderModel = self.allOrderInfo[count];
            sum += orderModel.price.doubleValue;
        }
        headerLabel.text = [NSString stringWithFormat:@"成功%lu张                                  总票价: %.2lf",(unsigned long)self.passengerInfoTrans.count,sum];
        [customView addSubview:headerLabel];
        return customView;

    } else return  nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.allOrderInfo.count;
    } else return 1;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderInfo *model = self.allOrderInfo[indexPath.row];
    OrderPayTableViewCell * cell;
    if (indexPath.section == 0) {
        static NSString *ID = @"trainInfo_cell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderPayTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.orderInfo = model;
        
    } else if (indexPath.section == 1) {

        static NSString *ID = @"passengerInfo_cell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderPayTableViewCell" owner:nil options:nil] lastObject];
        }
        cell.orderInfo = model;
        
        
    } else if (indexPath.section == 2){
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"立即支付" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"okButton_1"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"okButton_2"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        [button addTarget:self action:@selector(confirmChoice) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        button.frame = CGRectMake(-40, 0, 400, 48);
        return cell;
        
    }  else if (indexPath.section == 3){
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"取消订单" forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"okButton_2"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"okButton_2"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        [button addTarget:self action:@selector(cancelChoice) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        button.frame = CGRectMake(-40, 0, 400, 48);
        return cell;
    }

    
    return cell;
}

- (void)confirmChoice
{
    [self performSegueWithIdentifier:@"toPayView" sender:nil];
}

- (void)cancelChoice
{
    //设置注销Alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要取消订单？" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction* logOutAction = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action ) {
                                                             NSLog(@"hahaha");
                                                             //返回主界面
//                                                             [self performSegueWithIdentifier:@"logOutToMainMenu" sender:nil];
                                                             [self performSegueWithIdentifier:@"toTicketMainView" sender:nil];
                                                             
                                                         }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action ) {}];
    [alert addAction:logOutAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section== 0) {
        return 69;
    } if (indexPath.section == 1) {
        return 44;
    } else return 48;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    } else if (section == 1) {
        return 0.1;
    } else if (section == 3) {
        return 10;
    } else
        return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == 1 ) {
//        return 20;
//    } else return 0;
        return 0.1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toPayView"]) {
        PaymentChoiceTableViewController *payView = segue.destinationViewController;
        payView.username = self.username;
        payView.orderNumberInfoTrans = self.orderNumberInfoTrans;
        payView.ticketInfoTrans = self.ticketInfoTrans;
    }
}



- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
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
