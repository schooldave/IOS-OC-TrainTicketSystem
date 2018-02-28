//
//  TicketInfoCell.h
//  CellExpand
//
//  Created by schooldave on 3/22/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TicketInfo;
@interface TicketInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *expandButton;
@property (weak, nonatomic) IBOutlet UIButton *sectionButton;


@property (nonatomic, strong) TicketInfo *ticketInfo;
@end
