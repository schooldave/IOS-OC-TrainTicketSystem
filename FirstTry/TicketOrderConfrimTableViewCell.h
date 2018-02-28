//
//  TicketOrderConfrimTableViewCell.h
//  FirstTry
//
//  Created by schooldave on 4/4/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketInfo.h"

@interface TicketOrderConfrimTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *businessButton;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (nonatomic, strong) TicketInfo *ticketInfo;
@property (weak, nonatomic) IBOutlet UIButton *addPersonButton;
@property (weak, nonatomic) IBOutlet UIButton *submitOrderButton;



@end
