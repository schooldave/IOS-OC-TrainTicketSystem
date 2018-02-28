//
//  AdminTicketDataTableViewController.m
//  FirstTry
//
//  Created by schooldave on 3/30/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "AdminTicketDataTableViewController.h"

@interface AdminTicketDataTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;
@property (weak, nonatomic) IBOutlet UIButton *cleanTicketDataButton;
@property (weak, nonatomic) IBOutlet UIButton *addTicketDataButton;
@property (weak, nonatomic) IBOutlet UIButton *cleanTrainDataButton;
@property (weak, nonatomic) IBOutlet UIButton *addTrainDataButton;

@end

@implementation AdminTicketDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cleanTicketDataButton addTarget:self action:@selector(cleanTicketData) forControlEvents:UIControlEventTouchUpInside];
    [self.addTicketDataButton addTarget:self action:@selector(addTicketData) forControlEvents:UIControlEventTouchUpInside];
    [self.cleanTrainDataButton addTarget:self action:@selector(cleanTrainData) forControlEvents:UIControlEventTouchUpInside];
    [self.addTrainDataButton addTarget:self action:@selector(addTrainData) forControlEvents:UIControlEventTouchUpInside];
}


- (void)addTicketData
{
    NSLog(@"addTicketData");
    
    //Just for input train/ticket data
    //T_TicketInfo
    //trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TicketInfo(trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date) values('G1', '北京南', '09:00', '南京南','12:40','03时40分','1403.5','748.5','443.5','100','100','100','2017-03-30');"]];
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TicketInfo(trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date) values('G1', '北京南', '09:00', '上海虹桥','13:49','04时49分','1748.0','933.0','553.0','100','100','100','2017-03-31');"]];
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TicketInfo(trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date) values('G359', '南京南', '13:36', '上海虹桥','14:43','01时07分','429.5','229.5','134.5','100','100','100','2017-03-30');"]];

}

- (void)cleanTicketData
{
    NSLog(@"cleanTicketData");
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM 'T_TicketInfo'"];
    [[SqlTool shareinstance] deleteData:deleteSql];
}

- (void)addTrainData
{
    NSLog(@"addTrainData");
    
    
    //T_TrainInfo
    //station,trainNumber,arriveTime,startTime,stationOrder,totalNumber
    //    NSString *insertSqlForTrainInfo = [NSString stringWithFormat:@"insert into T_TrainInfo(station,trainNumber,arriveTime,startTime,stationOrder,totalNumber) values('北京南', 'G1', '----', '09:00','1','3');"];
    //G1
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TrainInfo(station,trainNumber,arriveTime,startTime,stationOrder,totalNumber) values('北京南', 'G1', '----', '09:00','1','3');"]];
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TrainInfo(station,trainNumber,arriveTime,startTime,stationOrder,totalNumber) values('南京南', 'G1', '12:40', '12:42','2','3');"]];
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TrainInfo(station,trainNumber,arriveTime,startTime,stationOrder,totalNumber) values('上海虹桥', 'G1', '13:49', '----','3','3');"]];
    
    //G359
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TrainInfo(station,trainNumber,arriveTime,startTime,stationOrder,totalNumber) values('西安北', 'G359', '----', '08:45','1','5');"]];
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TrainInfo(station,trainNumber,arriveTime,startTime,stationOrder,totalNumber) values('郑州东', 'G359', '10:39', '10:43','2','5');"]];
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TrainInfo(station,trainNumber,arriveTime,startTime,stationOrder,totalNumber) values('徐州东', 'G359', '12:13', '12:17','3','5');"]];
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TrainInfo(station,trainNumber,arriveTime,startTime,stationOrder,totalNumber) values('南京南', 'G359', '13:32', '13:36','4','5');"]];
    [[SqlTool shareinstance] insertData:[NSString stringWithFormat:@"insert into T_TrainInfo(station,trainNumber,arriveTime,startTime,stationOrder,totalNumber) values('上海虹桥', 'G359', '14:32', '----','5','5');"]];
    
    
}





















- (void)cleanTrainData
{
    NSLog(@"cleanTrainData");
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM 'T_TrainInfo'"];
    [[SqlTool shareinstance] deleteData:deleteSql];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
