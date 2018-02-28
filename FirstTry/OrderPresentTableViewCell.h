//
//  OrderPresentTableViewCell.h
//  FirstTry
//
//  Created by schooldave on 4/20/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
@interface OrderPresentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;



@property (strong, nonatomic) OrderInfo *orderInfo;


@end
