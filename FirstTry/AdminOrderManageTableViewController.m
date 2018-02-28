//
//  AdminOrderManageTableViewController.m
//  FirstTry
//
//  Created by schooldave on 3/30/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "AdminOrderManageTableViewController.h"
#import "UserInfo.h"
#import "UserInfoTableViewCell.h"
#import "OrderInfo.h"
#import "OrderPresentTableViewCell.h"
#import "SqlTool.h"


@interface AdminOrderManageTableViewController ()

@property (strong, nonatomic) NSArray *allOrderInfo;


@end

@implementation AdminOrderManageTableViewController

-(NSArray *)allOrderInfo
{
    
    NSString *searchSql = [NSString stringWithFormat:@"select orderNumber,trainNumber,startStation,startTime,arriveStation,arriveTime,duration,idCardNumber,name,username,price,seatClass, paymentState,date from T_OrderInfo"];
    NSMutableArray *resultArrayDict = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:4];
    NSLog(@"find %lu",(unsigned long)resultArrayDict.count);
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in resultArrayDict) {
        OrderInfo *model = [OrderInfo orderInfoWithDict:dict];
        [arrayModels addObject: model];
    }
    _allOrderInfo = arrayModels;

    return _allOrderInfo;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allOrderInfo.count;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderInfo *model;
    static NSString *ID = @"orderPresent_cell";
    OrderPresentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderPresentTableViewCell" owner:nil options:nil] firstObject];
    }
    model = self.allOrderInfo[indexPath.row];
    cell.orderInfo = model;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderInfo *orderInfo = self.allOrderInfo[indexPath.row];
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM T_OrderInfo where orderNumber = '%@'",orderInfo.orderNumber];
    
    //设置注销Alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除订单" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction* refundAction = [UIAlertAction actionWithTitle:@"删除订单" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action ) {
                                                             NSLog(@"hahaha");
                                                             //返回主界面
                                                             [[SqlTool shareinstance] deleteData:deleteSql];
                                                             [self.tableView reloadData];
                                                             
                                                             
                                                         }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action ) {}];
    [alert addAction:refundAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
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
    headerLabel.frame = CGRectMake(0.0, 10.0, 300.0, 30.0);
    headerLabel.text = [NSString stringWithFormat:@"* 左滑删除订单"];
    [customView addSubview:headerLabel];
    return customView;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除订单";

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

@end
