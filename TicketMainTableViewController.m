//
//  TicketMainTableViewController.m
//  FirstTry
//
//  Created by schooldave on 3/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "TicketMainTableViewController.h"
#import "TicketInfoViewController.h"

@interface TicketMainTableViewController ()<DateSelectedViewControllerDelegate,CitySearchViewControllerDelegate,TicketInfoViewControllerDelegate>
//@property (weak, nonatomic) IBOutlet UIButton *dateSelectedButton;
@property (weak, nonatomic) IBOutlet UIButton *exchangePlaceButton;
@property (weak, nonatomic) IBOutlet UIButton *startStationButton;
@property (weak, nonatomic) IBOutlet UIButton *arriveStationButton;


@end



@implementation TicketMainTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.dateSelectedButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.exchangePlaceButton addTarget:self action:@selector(exchangePlace) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.backBarButtonItem.title = @"";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)exchangePlace{
    NSString *tmp = self.startStationButton.titleLabel.text;
    [self.startStationButton setTitle:self.arriveStationButton.titleLabel.text forState:UIControlStateNormal];
    [self.arriveStationButton setTitle:tmp forState:UIControlStateNormal];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toDateSelected"]){
        DateSelectedViewController *dateSelectedView = segue.destinationViewController;
        dateSelectedView.delegate = self;
    } else if ([segue.identifier isEqualToString:@"toStartStaionView"] || [segue.identifier isEqualToString:@"toArriveStaionView"]){
        CitySearchViewController *citySelected = segue.destinationViewController;
        citySelected.delegate = self;
        if ([segue.identifier isEqualToString:@"toStartStaionView"]) {
            citySelected.isStart = YES;
        } else citySelected.isStart = NO;
    } else if ([segue.identifier isEqualToString:@"toTicketInfoViewController"])
    {
        TicketInfoViewController *ticketInfoView = segue.destinationViewController;
        ticketInfoView.startStation = self.startStationButton.titleLabel.text;
        ticketInfoView.arriveStation = self.arriveStationButton.titleLabel.text;
        ticketInfoView.date = self.dateSelectedButton.titleLabel.text;
        ticketInfoView.username = self.username;
        ticketInfoView.delegate = self;
    }
   
    
}

-(void)citySelectedViewController:(CitySearchViewController *)citySearchViewController withCity:(NSString *)city andIsStart:(BOOL)isStart
{
    if (isStart) {
        [self.startStationButton setTitle:city forState:UIControlStateNormal];
    } else {

        [self.arriveStationButton setTitle:city forState:UIControlStateNormal];
    }
    NSLog(@"%@",city);
}

- (void)dateSelectedViewController:(DateSelectedViewController *)dateSelectedViewController withDate:(NSString *)date
{
    [self.dateSelectedButton setTitle:date forState:UIControlStateNormal];
//    self.dateSelectedButton.titleLabel.text = date;
}

- (void)ticketInfoViewController:(TicketInfoViewController *)ticketInfoViewController withDate:(NSString *)date
{
    [self.dateSelectedButton setTitle:date forState:UIControlStateNormal];
}

@end
