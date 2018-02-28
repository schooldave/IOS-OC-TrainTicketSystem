//
//  TrainInfoCell.m
//  CellExpand
//
//  Created by schooldave on 3/25/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "TrainInfoCell.h"
#import "TrainInfo.h"

@interface TrainInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *lblStationOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblStation;
@property (weak, nonatomic) IBOutlet UILabel *lblArriveTime;
@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;


@end


@implementation TrainInfoCell

- (void)setTrainInfo:(TrainInfo *)trainInfo
{
    _trainInfo = trainInfo;
    //把模型数据设置给子控件
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];

    self.lblStationOrder.text = [numberFormatter stringFromNumber:trainInfo.stationOrder];
    self.lblStation.text = trainInfo.station;
    self.lblArriveTime.text = trainInfo.arriveTime;
    self.lblStartTime.text = trainInfo.startTime;
    
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
