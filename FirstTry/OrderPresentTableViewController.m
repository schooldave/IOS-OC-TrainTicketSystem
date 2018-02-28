//
//  OrderPresentTableViewController.m
//  FirstTry
//
//  Created by schooldave on 4/19/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "OrderPresentTableViewController.h"
#import "OrderInfo.h"
#import "OrderPresentTableViewCell.h"
#import "SqlTool.h"
#import "SVProgressHUD.h"
#import "PaymentChoiceTableViewController.h"

@interface OrderPresentTableViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (weak, nonatomic) NSArray *allOrderInfoPayed;
@property (weak, nonatomic) NSArray *allOrderInfoUnpayed;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


@end

NSArray *orderNumberTrans;

@implementation OrderPresentTableViewController

- (NSArray *)allOrderInfoPayed
{

    //    if (_allOrderInfoPayed == nil) {

    NSString *searchSql = [NSString stringWithFormat:@"select orderNumber,trainNumber,startStation,startTime,arriveStation,arriveTime,duration,idCardNumber,name,username,price,seatClass, paymentState,date from T_OrderInfo where paymentState = '%@' and username = '%@'", @"YES", self.username];
//    }
    
    NSMutableArray *resultArrayDict = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:4];
    NSLog(@"find %lu",(unsigned long)resultArrayDict.count);
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in resultArrayDict) {
        OrderInfo *model = [OrderInfo orderInfoWithDict:dict];
        [arrayModels addObject: model];
    }
    _allOrderInfoPayed = arrayModels;
    //    }
    return _allOrderInfoPayed;

}

- (NSArray *)allOrderInfoUnpayed
{
    //    if (_allOrderInfoUnpayed == nil) {
    
    NSString *searchSql = [NSString stringWithFormat:@"select orderNumber,trainNumber,startStation,startTime,arriveStation,arriveTime,duration,idCardNumber,name,username,price,seatClass, paymentState,date from T_OrderInfo where paymentState = '%@' and username = '%@'", @"NO", self.username];
    //    }
    
    NSMutableArray *resultArrayDict = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:4];
    NSLog(@"find %lu",(unsigned long)resultArrayDict.count);
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in resultArrayDict) {
        OrderInfo *model = [OrderInfo orderInfoWithDict:dict];
        [arrayModels addObject: model];
    }
    _allOrderInfoUnpayed = arrayModels;
    //    }
    return _allOrderInfoUnpayed;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.segmentedControl.selectedSegmentIndex == 0) {
        return self.allOrderInfoPayed.count;
    } else
        return self.allOrderInfoUnpayed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderInfo *model;
    static NSString *ID = @"orderPresent_cell";
    OrderPresentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderPresentTableViewCell" owner:nil options:nil] firstObject];
    }
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        model = self.allOrderInfoPayed[indexPath.row];
        
    } else {
        model = self.allOrderInfoUnpayed[indexPath.row];
        [cell.selectButton setTag:indexPath.row];
        [cell.selectButton addTarget:self action:@selector(continuePay:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    cell.orderInfo = model;
    return cell;
}

- (void)continuePay: (UIButton *)sender
{
    NSLog(@"ddddd");
    OrderInfo *model = self.allOrderInfoUnpayed[sender.tag];
    orderNumberTrans = [NSArray arrayWithObject: model.orderNumber];
//    if (self.segmentedControl.selectedSegmentIndex == 0) {
//        <#statements#>
//    }
    [self performSegueWithIdentifier:@"toPaymentChoice" sender:nil];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toPaymentChoice"]) {
        PaymentChoiceTableViewController *payView = segue.destinationViewController;
        payView.orderNumberInfoTrans = orderNumberTrans;
        payView.username = self.username;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 30.0)];
    // create the button object
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:15];
    headerLabel.frame = CGRectMake(10.0, 10.0, 300.0, 30.0);
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        headerLabel.text = [NSString stringWithFormat:@"* 左滑退票"];
    } else if (self.segmentedControl.selectedSegmentIndex == 1){
        headerLabel.text = [NSString stringWithFormat:@"* 左滑取消订单"];
    }
    [customView addSubview:headerLabel];
    return customView;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    if (section == 1 ) {
    //        return 20;
    //    } else return 0;
    return 40;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *orderNumber;
    OrderInfo *orderInfo;
    NSString *alertStr;
    NSString *refundStr;
    NSString *seatClass;
    NSNumber *count;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        orderInfo = self.allOrderInfoPayed[indexPath.row];
        orderNumber = orderInfo.orderNumber;
        alertStr = @"确定要退票?";
        refundStr = @"退票";
    } else if (self.segmentedControl.selectedSegmentIndex == 1){
        orderInfo = self.allOrderInfoUnpayed[indexPath.row];
        orderNumber = orderInfo.orderNumber;
        alertStr = @"确定要取消订单?";
        refundStr = @"取消订单";
    }

    
    seatClass = orderInfo.seatClass;
    
    if ([seatClass isEqualToString:@"businessPrice"]) {
        seatClass = @"businessCount";
    } else if ([seatClass isEqualToString:@"firstPrice"]) {
        seatClass = @"firstCount";
    } else
        seatClass = @"secondCount";
    

    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM T_OrderInfo where orderNumber = '%@'",orderNumber];
    
    NSString *searchSql = [NSString stringWithFormat:@"select trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date from T_TicketInfo where trainNumber = '%@' and startStation = '%@' and arriveStation = '%@' and date = '%@'", orderInfo.trainNumber, orderInfo.startStation, orderInfo.arriveStation, orderInfo.date];
    NSMutableArray *resultArrayDict = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:1];
    
    count = resultArrayDict[0][seatClass];
    count = [NSNumber numberWithInt:count.intValue + 1];
    NSLog(@"dddd %@",count);
    NSString *modifySqlForTicket = [NSString stringWithFormat:@"update T_TicketInfo set '%@' = '%@' where trainNumber = '%@' and startStation = '%@' and arriveStation = '%@' and date = '%@'", seatClass,[NSString stringWithFormat:@"%@",count], orderInfo.trainNumber, orderInfo.startStation, orderInfo.arriveStation, orderInfo.date];

    //设置注销Alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertStr message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction* refundAction = [UIAlertAction actionWithTitle:refundStr style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action ) {
                                                             NSLog(@"hahaha");
                                                             //返回主界面
                                                             [[SqlTool shareinstance] deleteData:deleteSql];
                                                             [[SqlTool shareinstance] modifyData:modifySqlForTicket];
                                                             
                                                             
                                                             
                                                             
                                                             [self.tableView reloadData];

                                                             
                                                         }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action ) {}];
    [alert addAction:refundAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return @"退票";
    } else
        return @"取消订单";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}


- (void)segmentedChange
{
    [self.tableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;    
//    if (self.segmentedControl.selectedSegmentIndex == 0 ) {
//        self.editButtonItem.title = @"退票";
//    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
//        self.editButtonItem.title = @"取消订单";
//    }

    [self.segmentedControl addTarget:self action:@selector(segmentedChange) forControlEvents:UIControlEventValueChanged];
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
