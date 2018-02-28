//
//  OrderPresentTableViewCell.m
//  FirstTry
//
//  Created by schooldave on 4/20/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "OrderPresentTableViewCell.h"

@interface OrderPresentTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *lblTrainNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblStartStation;
@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblArriveStation;
@property (weak, nonatomic) IBOutlet UILabel *lblArriveTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *paymantState;
@property (weak, nonatomic) IBOutlet UILabel *ticketPrice;
@property (weak, nonatomic) IBOutlet UILabel *seatClass;
@property (weak, nonatomic) IBOutlet UILabel *date;



@end


@implementation OrderPresentTableViewCell


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
    
    if ([orderInfo.paymentState isEqualToString:@"YES"]) {
        self.paymantState.text = @"已支付";
    } else self.paymantState.text = @"待支付";
    

    self.ticketPrice.text = [NSString stringWithFormat:@"¥%@",orderInfo.price];
    
    if ([orderInfo.seatClass isEqualToString:@"business"]) {
        self.seatClass.text = @"商务座";
    } else if ([orderInfo.seatClass isEqualToString:@"first"]) {
        self.seatClass.text = @"一等座";
    } else if ([orderInfo.seatClass isEqualToString:@"second"]) {
        self.seatClass.text = @"二等座";
    }
    
    self.date.text = orderInfo.date;
    
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
