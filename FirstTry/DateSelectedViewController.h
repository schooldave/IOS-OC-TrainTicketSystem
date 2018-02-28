//
//  DateSelectedViewController.h
//  FirstTry
//
//  Created by schooldave on 3/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Daysquare.h"

@class DateSelectedViewController;

@protocol DateSelectedViewControllerDelegate <NSObject>

@optional

- (void)dateSelectedViewController: (DateSelectedViewController *)dateSelectedViewController withDate: (NSString *)date;

@end




@interface DateSelectedViewController : UIViewController


@property (nonatomic, weak) id<DateSelectedViewControllerDelegate>delegate;

@end
