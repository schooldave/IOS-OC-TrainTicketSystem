//
//  TicketOrderViewController.m
//  FirstTry
//
//  Created by schooldave on 4/4/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "TicketOrderViewController.h"
#import "SVProgressHUD.h"
#import "OrderPayTableViewController.h"
#import "SqlTool.h"

@interface TicketOrderViewController ()<UITableViewDataSource,UITableViewDelegate,addPassengerTableViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *orderConfirmTableView;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@end

TicketOrderConfrimTableViewCell *cellForInfo;
NSMutableArray *passengerArray;
NSMutableArray *orderNumberArray;
NSString *seatClass;


@implementation TicketOrderViewController

//- (TicketInfo *)ticketInfoTrans
//{
//    if (self.transferLeftArray.count != 0) {
//        _ticketInfoTrans = self.transferLeftArray.firstObject;
//    }
//    return _ticketInfoTrans;
//}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        static NSString *ID = @"ticketOrderConfirm_cell";
//        cellForInfo = [tableView dequeueReusableCellWithIdentifier:ID];
//        if (cellForInfo == nil) {
//            cellForInfo = [[[NSBundle mainBundle] loadNibNamed:@"TicketOrderConfirmCell" owner:nil options:nil] firstObject];
//        }
//        cellForInfo.ticketInfo = self.ticketInfoTrans;
//        [cellForInfo.businessButton setTag:0];
//        [cellForInfo.firstButton setTag:1];
//        [cellForInfo.secondButton setTag:2];
//        cellForInfo.businessButton.selected = NO;
//        cellForInfo.firstButton.selected = NO;
//        cellForInfo.secondButton.selected = YES;
//        [cellForInfo.businessButton addTarget:self action:@selector(selectedClass:) forControlEvents:UIControlEventTouchUpInside];
//        [cellForInfo.firstButton addTarget:self action:@selector(selectedClass:) forControlEvents:UIControlEventTouchUpInside];
//        [cellForInfo.secondButton addTarget:self action:@selector(selectedClass:) forControlEvents:UIControlEventTouchUpInside];
////        //将cell加一层layout，防止cell放在header上会变为空
////        UIView * view = [[UIView alloc] initWithFrame:cellForInfo.frame];
////        cellForInfo.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
////        [view addSubview:cellForInfo];
//        return cellForInfo;
//    } else return nil;
//}

- (void)selectedClass: (UIButton *)sender
{
    if (sender.tag == 0) {
        cellForInfo.businessButton.selected = YES;
        cellForInfo.firstButton.selected = NO;
        cellForInfo.secondButton.selected = NO;
        seatClass = @"businessPrice";
        NSLog(@"0");
    }
    if (sender.tag == 1) {
        cellForInfo.businessButton.selected = NO;
        cellForInfo.firstButton.selected = YES;
        cellForInfo.secondButton.selected = NO;
        seatClass = @"firstPrice";
        NSLog(@"1");
    }
    if (sender.tag == 2) {
        cellForInfo.businessButton.selected = NO;
        cellForInfo.firstButton.selected = NO;
        cellForInfo.secondButton.selected = YES;
        seatClass = @"secondPrice";
        NSLog(@"2");
    }
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return passengerArray.count;
    } else if (section == 0) {
        return 1;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
    //创建单元格
    //通过xib的方式崃创建单元格
//    static NSString *ID = @"ticketOrderConfirm_cell";
    TicketOrderConfrimTableViewCell *cell;

//    if(indexPath.section == 0) {
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"TicketOrderConfirmCell" owner:nil options:nil] firstObject];
//        }
//        cell.ticketInfo = self.ticketInfoTrans;
//    }
    if (indexPath.section == 0) {
        static NSString *ID = @"ticketOrderConfirm_cell";
        cellForInfo = [tableView dequeueReusableCellWithIdentifier:ID];
        cellForInfo = [[[NSBundle mainBundle] loadNibNamed:@"TicketOrderConfirmCell" owner:nil options:nil] firstObject];
    
        cellForInfo.ticketInfo = self.ticketInfoTrans;
        [cellForInfo.businessButton setTag:0];
        [cellForInfo.firstButton setTag:1];
        [cellForInfo.secondButton setTag:2];
        cellForInfo.businessButton.selected = NO;
        cellForInfo.firstButton.selected = NO;
        cellForInfo.secondButton.selected = YES;
        [cellForInfo.businessButton addTarget:self action:@selector(selectedClass:) forControlEvents:UIControlEventTouchUpInside];
        [cellForInfo.firstButton addTarget:self action:@selector(selectedClass:) forControlEvents:UIControlEventTouchUpInside];
        [cellForInfo.secondButton addTarget:self action:@selector(selectedClass:) forControlEvents:UIControlEventTouchUpInside];
        return cellForInfo;
    }
    if (indexPath.section == 1) {
        static NSString *ID = @"ticketInfo_cell";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.textLabel.text = passengerArray[indexPath.row][@"name"];
        cell.detailTextLabel.text = passengerArray[indexPath.row][@"idCardNumber"];
        return cell;
//        if (cell == nil) {
//            cell = [[NSBundle mainBundle] loadNibNamed:@"TicketOrderConfirmCell" owner:nil options:nil][1] ;
//        }
    }
    if (indexPath.section == 2 ) {
        static NSString *ID = @"ticketOrderAddPerson_cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TicketOrderConfirmCell" owner:nil options:nil][1] ;
        }
      
    }
    if (indexPath.section == 3 ) {
        static NSString *ID = @"ticketOrderConfirm_cell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TicketOrderConfirmCell" owner:nil options:nil] lastObject];
        }
       
    }
    [cell.addPersonButton addTarget:self action:@selector(addPassenger) forControlEvents:UIControlEventTouchUpInside];
    [cell.submitOrderButton addTarget:self action:@selector(orderConfirm) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [passengerArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return YES;
    } else return NO;
}
- (void)addPassengerTableViewController:(AddPassengerTableViewController *)addPassengerTableViewController andPassenger:(NSArray *)passenger
{
    passengerArray = [NSMutableArray arrayWithArray:passenger];
    
//    [self.orderConfirmTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    [self.orderConfirmTableView reloadData];
}
- (void)addPassenger
{
    [self performSegueWithIdentifier:@"toAddPassenger" sender:nil];
}

- (void)orderConfirm
{
    if (passengerArray.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择至少一名乘客"];
        [SVProgressHUD dismissWithDelay:1];
        NSLog(@"fff");
    } else {
        NSUInteger orderCount = passengerArray.count;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYYMMddHHmmss"];
        NSDate *datenow = [NSDate date];
        NSString *nowtimeStr = [formatter stringFromDate:datenow];
        NSNumber *ticketCountChange;
        NSNumber *price;
        NSString *seat;
        if ([seatClass isEqualToString:@"businessPrice"]) {
            price = self.ticketInfoTrans.businessPrice;
            seat = @"businessCount";
            ticketCountChange = self.ticketInfoTrans.businessCount;
        } else if ([seatClass isEqualToString:@"firstPrice"]) {
            price = self.ticketInfoTrans.firstPrice;
            ticketCountChange = self.ticketInfoTrans.firstCount;
            seat = @"firstCount";
        } else {
            price = self.ticketInfoTrans.secondPrice;
            ticketCountChange = self.ticketInfoTrans.secondCount;
            seat = @"secondCount";
        }
        
        while (orderCount--) {
            ticketCountChange = [NSNumber numberWithInt:ticketCountChange.intValue - 1];
            NSString *orderNumber = [NSString stringWithFormat:@"%@T%@R%u",self.ticketInfoTrans.trainNumber,nowtimeStr,arc4random() % 100];
            [orderNumberArray addObject:orderNumber];
            NSLog(@"%@\n",orderNumber);
            NSString *insertSql = [NSString stringWithFormat:@"insert into T_OrderInfo (orderNumber,trainNumber,startStation,startTime,arriveStation,arriveTime,duration,idCardNumber,name,username,price,seatClass, paymentState,date) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@');", orderNumber,self.ticketInfoTrans.trainNumber,self.ticketInfoTrans.startStation,self.ticketInfoTrans.startTime,self.ticketInfoTrans.arriveStation,self.ticketInfoTrans.arriveTime,self.ticketInfoTrans.duration,passengerArray[orderCount][@"idCardNumber"],passengerArray[orderCount][@"name"],self.username,[NSString stringWithFormat: @"%@", price], seatClass,@"NO",self.ticketInfoTrans.date];
            [[SqlTool shareinstance] insertData:insertSql];
            
//            NSString *searchSql = [NSString stringWithFormat:@"select orderNumber,trainNumber,startStation,startTime,arriveStation,arriveTime,duration,idCardNumber,name,username,price,seatClass, paymentState,date from T_OrderInfo where orderNumber = '%@'", orderNumber];
//            NSMutableArray *resultArrayDict = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:4];
//            NSString *seatClass = resultArrayDict[0][@"seatClass"];
//            NSLog(@"1234154ffffffff %@",seatClass);
//            NSString *updateClas;
//            NSNumber *count;
//            if ([seatClass isEqualToString:@"businessPrice"]) {
//                updateClas = @"businessCount";
//                count = self.ticketInfoTrans.businessCount;
//            } else if ([seatClass isEqualToString:@"firstPrice"]) {
//                updateClas = @"firstCount";
//                count = self.ticketInfoTrans.firstCount;
//            } else {
//                updateClas = @"secondCount";
//                count = self.ticketInfoTrans.secondCount;
//            }
            NSString *modifySqlForTicket = [NSString stringWithFormat:@"update T_TicketInfo set '%@' = '%@' where trainNumber = '%@' and startStation = '%@' and arriveStation = '%@' and date = '%@'", seat,[NSString stringWithFormat:@"%@",ticketCountChange], self.ticketInfoTrans.trainNumber, self.ticketInfoTrans.startStation, self.ticketInfoTrans.arriveStation, self.ticketInfoTrans.date];
            [[SqlTool shareinstance] modifyData:modifySqlForTicket];
        
            
        }
        [self performSegueWithIdentifier:@"toOrderPay" sender:nil];
    }
    NSLog(@"dd");
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAddPassenger"]) {
        AddPassengerTableViewController *addPassenger = segue.destinationViewController;
        addPassenger.username = self.username;
        addPassenger.delegate = self;
    } if ([segue.identifier isEqualToString:@"toOrderPay"]) {
        OrderPayTableViewController *orderPay = segue.destinationViewController;
        orderPay.ticketInfoTrans = self.ticketInfoTrans;
        orderPay.passengerInfoTrans = passengerArray;
        orderPay.orderNumberInfoTrans = orderNumberArray;
        orderPay.username = self.username;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 44;
    } else if (indexPath.section == 2) {
        return 30;
    } else  if (indexPath.section == 0) {
        return 135;
    }else return 60;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 3 || section == 2) {
//        return 10;
//    } else if (section == 0) {
//        return 135;
//    } else return 10;
    if (section == 0 || section == 1) {
        return 0;
    } else
    return 10;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    seatClass = @"secondPrice";
    passengerArray = [NSMutableArray array];
    orderNumberArray = [NSMutableArray array];
    self.orderConfirmTableView.delegate = self;
    self.orderConfirmTableView.dataSource = self;
    [self.dateButton setTitle:self.dateConfirm forState:UIControlStateNormal];
    _orderConfirmTableView.tableFooterView = [[UIView alloc]init];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
