//
//  TicketOrderConfrimTableViewCell.m
//  FirstTry
//
//  Created by schooldave on 4/4/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "TicketOrderConfrimTableViewCell.h"

@interface TicketOrderConfrimTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *lblTrainNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblStartStation;
@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblArriveStation;
@property (weak, nonatomic) IBOutlet UILabel *lblArriveTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;
@property (weak, nonatomic) IBOutlet UILabel *lblBusinessCount;
@property (weak, nonatomic) IBOutlet UILabel *lblFirstCount;
@property (weak, nonatomic) IBOutlet UILabel *lblSecondCount;
@property (weak, nonatomic) IBOutlet UILabel *lblBusinessPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblFirstPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblSecondPrice;



@end

@implementation TicketOrderConfrimTableViewCell

-(void)setTicketInfo:(TicketInfo *)ticketInfo
{
    
    _ticketInfo = ticketInfo;
    self.lblTrainNumber.text = ticketInfo.trainNumber;
    self.lblStartStation.text = ticketInfo.startStation;
    self.lblStartTime.text = ticketInfo.startTime;
    self.lblArriveStation.text = ticketInfo.arriveStation;
    self.lblArriveTime.text = ticketInfo.arriveTime;
    self.lblDuration.text = ticketInfo.duration;
    
    self.lblBusinessPrice.text = [NSString stringWithFormat:@"¥%@",ticketInfo.businessPrice];
    self.lblFirstPrice.text = [NSString stringWithFormat:@"¥%@",ticketInfo.firstPrice];
    self.lblSecondPrice.text = [NSString stringWithFormat:@"¥%@",ticketInfo.secondPrice];
    
    if ([[NSString stringWithFormat:@"%@",ticketInfo.businessCount] isEqualToString:@"0"]) {
        self.lblBusinessCount.text = @"无";
    } else self.lblBusinessCount.text = [NSString stringWithFormat:@"%@张",ticketInfo.businessCount];
    
    if ([[NSString stringWithFormat:@"%@",ticketInfo.firstCount] isEqualToString:@"0"]) {
        self.lblFirstCount.text = @"无";
    } else self.lblFirstCount.text = [NSString stringWithFormat:@"%@张",ticketInfo.firstCount];
    
    if ([[NSString stringWithFormat:@"%@",ticketInfo.secondPrice] isEqualToString:@"0"]) {
        self.lblSecondCount.text = @"无";
    } else self.lblSecondCount.text = [NSString stringWithFormat:@"%@张",ticketInfo.secondCount];
    
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
