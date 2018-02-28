//
//  CitySearchViewController.h
//  FirstTry
//
//  Created by schooldave on 3/13/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"
@class CitySearchViewController;
@protocol CitySearchViewControllerDelegate <NSObject>

@optional
- (void)citySelectedViewController: (CitySearchViewController *)citySearchViewController withCity: (NSString *)city andIsStart:(BOOL)isStart;

@end

@interface CitySearchViewController : UIViewController

@property (nonatomic, weak) id<CitySearchViewControllerDelegate>delegate;
@property (nonatomic, assign) BOOL isStart;

@end
