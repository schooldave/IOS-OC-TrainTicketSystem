//
//  TicketInfoCell.m
//  CellExpand
//
//  Created by schooldave on 3/22/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "TicketInfoCell.h"
#import "TicketInfo.h"

@interface TicketInfoCell()

@property (weak, nonatomic) IBOutlet UILabel *lblTrainNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblStartStation;
@property (weak, nonatomic) IBOutlet UILabel *lblArriveStation;
@property (weak, nonatomic) IBOutlet UILabel *lblBusinessPriceOrCount;
@property (weak, nonatomic) IBOutlet UILabel *lblFirstPriceOrCount;
@property (weak, nonatomic) IBOutlet UILabel *lblSecondPriceOrCount;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;
@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblArriveTime;


@end


@implementation TicketInfoCell

- (void)setTicketInfo:(TicketInfo *)ticketInfo
{
    _ticketInfo = ticketInfo;
    //把模型数据设置给子控件
    
//    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
    self.lblTrainNumber.text = ticketInfo.trainNumber;
    self.lblStartStation.text = ticketInfo.startStation;
    self.lblStartTime.text = ticketInfo.startTime;
    self.lblArriveStation.text = ticketInfo.arriveStation;
    self.lblArriveTime.text = ticketInfo.arriveTime;
    self.lblDuration.text = ticketInfo.duration;
    self.lblBusinessPriceOrCount.text = [NSString stringWithFormat:@"¥%@ / %@",ticketInfo.businessPrice,ticketInfo.businessCount];
//    self.lblBusinessPriceOrCount.text = [numberFormatter stringFromNumber:ticketInfo.businessPrice];
    self.lblFirstPriceOrCount.text = [NSString stringWithFormat:@"¥%@ / %@",ticketInfo.firstPrice,ticketInfo.firstCount];
    self.lblSecondPriceOrCount.text = [NSString stringWithFormat:@"¥%@ / %@",ticketInfo.secondPrice,ticketInfo.secondCount];
    
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
