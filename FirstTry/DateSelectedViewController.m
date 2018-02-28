//
//  DateSelectedViewController.m
//  FirstTry
//
//  Created by schooldave on 3/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "DateSelectedViewController.h"

@interface DateSelectedViewController ()
@property (weak, nonatomic) IBOutlet DAYCalendarView *dateView;

@end

@implementation DateSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.dateView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view.
}


- (void)calendarViewDidChange:(id)sender {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@", [formatter stringFromDate:self.dateView.selectedDate]);
    if ([self.delegate respondsToSelector:@selector(dateSelectedViewController:withDate:)]) {
        [self.delegate dateSelectedViewController:self withDate:[formatter stringFromDate:self.dateView.selectedDate]];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}


@end
