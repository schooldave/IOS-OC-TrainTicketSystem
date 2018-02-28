//
//  OrderPayTableViewCell.m
//  FirstTry
//
//  Created by schooldave on 4/15/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "OrderPayTableViewCell.h"

@interface OrderPayTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblTrainNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblStartStation;
@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblArriveStation;
@property (weak, nonatomic) IBOutlet UILabel *lblArriveTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *idCardNumber;
@property (weak, nonatomic) IBOutlet UILabel *ticketPrice;
@property (weak, nonatomic) IBOutlet UILabel *seatClass;

@end


@implementation OrderPayTableViewCell


- (void)setOrderInfo:(OrderInfo *)orderInfo
{
    _orderInfo = orderInfo;
    self.lblTrainNumber.text = orderInfo.trainNumber;
    self.lblStartStation.text = orderInfo.startStation;
    self.lblStartTime.text = orderInfo.startTime;
    self.lblArriveStation.text = orderInfo.arriveStation;
    self.lblArriveTime.text = orderInfo.arriveTime;
    self.lblDuration.text = orderInfo.duration;
    
    self.name.text = orderInfo.name;
    self.idCardNumber.text = orderInfo.idCardNumber;
    self.ticketPrice.text = [NSString stringWithFormat:@"¥%@",orderInfo.price];
    
    if ([orderInfo.seatClass isEqualToString:@"business"]) {
        self.seatClass.text = @"商务座";
    } else if ([orderInfo.seatClass isEqualToString:@"first"]) {
        self.seatClass.text = @"一等座";
    } else if ([orderInfo.seatClass isEqualToString:@"second"]) {
        self.seatClass.text = @"二等座";
    }
    
 
}

//- (void)setTickeInfo:(TicketInfo *)ticketInfo
//{
//    _ticketInfo = ticketInfo;
//    self.lblTrainNumber.text = ticketInfo.trainNumber;
//    self.lblStartStation.text = ticketInfo.startStation;
//    self.lblStartTime.text = ticketInfo.startTime;
//    self.lblArriveStation.text = ticketInfo.arriveStation;
//    self.lblArriveTime.text = ticketInfo.arriveTime;
//    self.lblDuration.text = ticketInfo.duration;
//
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
