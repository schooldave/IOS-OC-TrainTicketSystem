//
//  TicketInfoViewController.m
//  FirstTry
//
//  Created by schooldave on 3/26/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "TicketInfoViewController.h"
#import "DateSelectedViewController.h"
#import "SVProgressHUD.h"

#define kCell_Height 60
TicketInfo *transTicketInfoModel;
NSMutableArray *stateArray;
NSMutableArray *transferLeftArray;

NSString *tmpForTrainNumber;

@interface TicketInfoViewController ()<UITableViewDataSource,UITableViewDelegate,DateSelectedViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *dateButton;


@property (weak, nonatomic) IBOutlet UITableView *ticketResultTableView;
//用来存储所有的查询车票的数据
@property (nonatomic, strong) NSArray *allTicketInfo;
//用来存储 可换乘的车票数据
@property (strong, nonatomic) NSArray *allTransferInfo;

//用来存储所查询列车的信息
@property (nonatomic, strong) NSArray *allTrainInfo;

@end


@implementation TicketInfoViewController

#pragma mark - 懒加载数据 - allTicketInfo
- (NSArray *)allTicketInfo
{


//    if (_allTrainInfo == nil) {
        NSString *searchSql = [NSString stringWithFormat:@"select trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date from T_TicketInfo where startStation = '%@' AND arriveStation = '%@' AND date = '%@'",self.startStation,self.arriveStation,self.dateButton.titleLabel.text];
        NSArray *resultArrayDict =[[SqlTool shareinstance] searchData:searchSql andChooseTableNum:1];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in resultArrayDict) {
            TicketInfo *model = [TicketInfo ticketInfoWithDict:dict];
            [arrayModels addObject:model];
        }
         _allTicketInfo = arrayModels;

//    }
    return _allTicketInfo;
}

#pragma mark -懒加载数据- allTransferInfo
- (NSArray *)allTransferInfo
{
//    if (_allTransferInfo == nil) {
        NSString *searchSqlForStart = [NSString stringWithFormat:@"select trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date from T_TicketInfo where startStation = '%@' AND date = '%@'",self.startStation,self.dateButton.titleLabel.text];
        NSArray *resultArrayForStartDict = [[SqlTool shareinstance] searchData:searchSqlForStart andChooseTableNum:1];
        NSUInteger count = resultArrayForStartDict.count ;
        NSMutableArray *resultArrayDict = [NSMutableArray array];
        while ( count-- ) {
            NSString *transferStation = resultArrayForStartDict[count][@"arriveStation"];
            NSString *searchSqlForArrive = [NSString stringWithFormat:@"select trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date from T_TicketInfo where startStation = '%@' AND arriveStation = '%@' AND date = '%@'",transferStation,self.arriveStation,self.dateButton.titleLabel.text];
            NSArray *resultArrayForArrive = [[SqlTool shareinstance] searchData:searchSqlForArrive andChooseTableNum:1];
            if (resultArrayForArrive.count == 0) {
                NSLog(@"No Transfer For %@", transferStation);
            } else {
                [resultArrayDict addObject:resultArrayForStartDict[count]];
                [resultArrayDict addObjectsFromArray:resultArrayForArrive];
            }
        }
        //    
        //    NSString *searchSqlForArrive = [NSString stringWithFormat:@"select trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date from T_TicketInfo where arriveStation = '%@' AND date = '%@'",self.arriveStation,self.dateButton.titleLabel.text];
        //    NSArray *resultArrayForArrive = [[SqlTool shareinstance] searchData:searchSqlForArrive andChooseTableNum:1];
        //    NSArray *resultArrayDict =[[SqlTool shareinstance] searchData:searchSqlForStart andChooseTableNum:1];

        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in resultArrayDict) {
            TicketInfo *model = [TicketInfo ticketInfoWithDict:dict];
            [arrayModels addObject:model];
        }
        _allTransferInfo = arrayModels;
//    }
    return _allTransferInfo;
    
}


#pragma mark - 懒加载数据 - allTrainInfo
-(NSArray *)allTrainInfo
{
    //station,trainNumber,arriveTime,startTime,stationOrder,totalNumber
    
    NSString *searchSql = [NSString stringWithFormat:@"select station,trainNumber,arriveTime,startTime,stationOrder,totalNumber from T_TrainInfo where trainNumber = '%@'",tmpForTrainNumber];
    NSArray *resultArrayDict = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:2];

    NSMutableArray *arrayModels = [NSMutableArray array];
    [arrayModels addObject:@""];
    for (NSDictionary *dict in resultArrayDict) {
        TrainInfo *model = [TrainInfo trainInfoWithDict:dict];
        [arrayModels addObject:model];
    }
    _allTrainInfo = arrayModels;

    return _allTrainInfo;
}

//Use header to exhibit result cell
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (self.allTicketInfo.count == 0) {
        
            //获取模型数据
            TicketInfo *model = self.allTransferInfo[section];
            //创建的单元格
            //通过xib的方式来创建单元格
            static NSString *ID = @"ticketInfoResult_cell";
            TicketInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TicketInfo" owner:nil options:nil] firstObject];
            }
            //把模型数据设置给单元格
            cell.ticketInfo = model;
            [cell.expandButton setTag:section];
            [cell.sectionButton setTag:section];
            [cell.expandButton addTarget:self action:@selector(expandCell:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sectionButton addTarget:self action:@selector(selectedTrain:) forControlEvents:UIControlEventTouchUpInside];
            if ([stateArray[section] isEqualToString:@"1"]) {
                [cell.expandButton setBackgroundImage:[UIImage imageNamed:@"arrow_up" ] forState:UIControlStateNormal];
            }
            [cell setBackgroundColor:[UIColor whiteColor]];
            //将cell加一层layout，防止cell放在header上会变为空
            UIView * view = [[UIView alloc] initWithFrame:cell.frame];
            cell.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [view addSubview:cell];
            //返回单元格
            return view;
 
    } else {
        //获取模型数据
        TicketInfo *model = self.allTicketInfo[section];
        //创建的单元格
        //通过xib的方式来创建单元格
        static NSString *ID = @"ticketInfoResult_cell";
        TicketInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TicketInfo" owner:nil options:nil] firstObject];
        }
        //把模型数据设置给单元格
        cell.ticketInfo = model;

        [cell.expandButton setTag:section];
        [cell.sectionButton setTag:section];
        [cell.expandButton addTarget:self action:@selector(expandCell:) forControlEvents:UIControlEventTouchUpInside];
        [cell.sectionButton addTarget:self action:@selector(selectedTrain:) forControlEvents:UIControlEventTouchUpInside];
        if ([stateArray[section] isEqualToString:@"1"]) {
            [cell.expandButton setBackgroundImage:[UIImage imageNamed:@"arrow_up" ] forState:UIControlStateNormal];
        }
        [cell setBackgroundColor:[UIColor whiteColor]];
        //将cell加一层layout，防止cell放在header上会变为空
        UIView * view = [[UIView alloc] initWithFrame:cell.frame];
        cell.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [view addSubview:cell];
        //返回单元格
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 17;
    }
    return 25;
}


- (void)selectedTrain: (UIButton *)sender
{
    if (self.allTicketInfo.count == 0) {
        transTicketInfoModel = self.allTransferInfo[sender.tag];
        transferLeftArray = [NSMutableArray arrayWithArray:self.allTransferInfo];
        [transferLeftArray removeObjectAtIndex:sender.tag];
    } else {
        transTicketInfoModel = self.allTicketInfo[sender.tag];

    }

    [self performSegueWithIdentifier:@"toTicketOrderView" sender:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.allTicketInfo.count == 0) {
        if (self.allTransferInfo.count == 0) {
            self.ticketResultTableView.hidden = YES;
            return 0;
        } else {
            self.ticketResultTableView.hidden = NO;
            return self.allTransferInfo.count;
        }

    } else {
        self.ticketResultTableView.hidden = NO;
        return self.allTicketInfo.count;
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([stateArray[section] isEqualToString:@"1"]) {
        TrainInfo *trainInfo;
        if (self.allTicketInfo.count == 0) {
            trainInfo = self.allTransferInfo[section];
        } else
            trainInfo = self.allTicketInfo[section];
        tmpForTrainNumber = trainInfo.trainNumber;
        return self.allTrainInfo.count;
        
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *ID = @"trainInfoTitle_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TrainInfoTitle" owner:nil options:nil] firstObject];
        }
        return cell;
    } else {
//        if
        //获取模型数据
        TrainInfo *model = self.allTrainInfo[indexPath.row];
        //创建单元格
        //通过xib的方式来创建单元格
        static NSString *ID = @"trainInfoResult_cell";
        TrainInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TrainInfo" owner:nil options:nil] firstObject];
        }
        //把模型数据设置给单元格
        cell.trainInfo = model;
        //返回单元格
        return cell;
    }

}

//调整button的状态
- (void)expandCell: (UIButton *)sender
{
    if ([stateArray[sender.tag] isEqualToString:@"0"]) {
        [stateArray replaceObjectAtIndex:sender.tag withObject:@"1"];

    } else {
        [stateArray replaceObjectAtIndex:sender.tag withObject:@"0"];

    }
    [self.ticketResultTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

//T_TicketInfo
//trainNumber,startStation,startTime,arriveStation,arriveTime,duration,seatClass,ticketPrice,ticketCount,date

//T_TrainInfo
//station,trainNumber,arriveTime,startTime,stationOrder,totalNumber


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDateSelectedView"]) {
        DateSelectedViewController *dateSelectedView = segue.destinationViewController;
        dateSelectedView.delegate = self;
    } else if ( [segue.identifier isEqualToString:@"toTicketOrderView"])
    {

        TicketOrderViewController *ticketOrderView = segue.destinationViewController;
        ticketOrderView.ticketInfoTrans = transTicketInfoModel;
        ticketOrderView.dateConfirm = self.dateButton.titleLabel.text;
        ticketOrderView.username = self.username;
        ticketOrderView.transferLeftArray = transferLeftArray;
    }
    
}


- (void)dateSelectedViewController:(DateSelectedViewController *)dateSelectedViewController withDate:(NSString *)date
{
    [self.dateButton setTitle:date forState:UIControlStateNormal];

//    for (int i = 0; i < self.allTicketInfo.count; i++)
//    {
//        //所有的分区都是闭合
//        [stateArray addObject:@"0"];
//    }
//    for (int i = 0; i < self.allTransferInfo.count; i++) {
//        [stateArray addObject:@"0"];
//    }
    if (self.allTicketInfo.count != 0) {
        for (int i = 0; i< self.allTicketInfo.count; i++)
        {
            //所有的分区都是闭合
            [stateArray replaceObjectAtIndex:i withObject:@"0"];
        }
        
    } else {
        if (stateArray.count) {
            for (int i = 0; i < self.allTransferInfo.count; i++)
            {
                //所有的分区都是闭合
                [stateArray replaceObjectAtIndex:i withObject:@"0"];
            }
        } else {
            for (int i = 0; i< self.allTransferInfo.count; i++)
            {
                //所有的分区都是闭合
                [stateArray addObject:@"0"];
            }
        }
       
    }
    [self.ticketResultTableView reloadData];
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticketResultTableView.delegate = self;
    self.ticketResultTableView.dataSource = self;
    
    stateArray = [NSMutableArray array];
    self.navigationItem.title =  [[NSString alloc] initWithFormat:@"%@--->%@",self.startStation,self.arriveStation];
    [self.dateButton setTitle:self.date forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem.title = @"";
    if (self.allTicketInfo.count == 0) {
        for (int i = 0; i< self.allTransferInfo.count; i++)
        {
            //所有的分区都是闭合
            [stateArray addObject:@"0"];
        }

    } else {
        for (int i = 0; i < self.allTicketInfo.count; i++)
        {
            //所有的分区都是闭合
            [stateArray addObject:@"0"];
        }
    }
  
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    if (self.allTicketInfo.count == 0 && self.allTransferInfo.count == 0) {
        self.ticketResultTableView.hidden = YES;
        [SVProgressHUD showErrorWithStatus:@"未查询到相关列车及可换乘的列车"];
        [SVProgressHUD dismissWithDelay:1];
        
    } else {
        if (self.allTicketInfo.count != 0) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"查询到%lu趟列车",(unsigned long)self.allTicketInfo.count]];
            [SVProgressHUD dismissWithDelay:1];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"未找到相关直达列车，但为您查询到可换乘的列车"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (self.allTransferInfo.count != 0 && self.allTicketInfo.count == 0 ) {
//                              [SVProgressHUD dismissWithDelay:1];
//                } else {
//                    
//                }
//                
//            });
            [SVProgressHUD dismissWithDelay:2];
        }
       

    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(ticketInfoViewController:withDate:)]) {

        [self.delegate ticketInfoViewController:self withDate:self.dateButton.titleLabel.text];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCell_Height;
}

@end
