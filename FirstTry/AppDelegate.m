//
//  AppDelegate.m
//  FirstTry
//
//  Created by schooldave on 3/1/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

/*
 CREATE TABLE IF NOT EXISTS 'T_UserInfo' ('ticketNumber' TEXT NOT NULL,'trainNumber' TEXT,'start Station' TEXT,'startTime' TEXT,'arriveStation' TEXT,'arriveTime' TEXT,'idCardNumber' TEXT ,'username' TEXT, 'price' REAL, 'seatClass' TEXT, 'paymentState' TEXT, 'date' TEXT,PRIMARY KEY('ticketNumber'));
 
 */




#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    //open database lasted.
    NSString *databaseName = @"SystemDatabse.sqlite";
    
    NSString *sqlUserINfo = @"CREATE TABLE IF NOT EXISTS 'T_UserInfo' ('username' TEXT NOT NULL,'password' TEXT,'name' TEXT,'idCardNumber' TEXT,'phone' TEXT ,PRIMARY KEY('username'));";
    
    NSString *sqlPersonInfo = @"CREATE TABLE IF NOT EXISTS 'T_PersonInfo' ('name' TEXT,'idCardNumber' TEXT,'username' TEXT);";
    
    NSString *sqlTicketInfo = @"CREATE TABLE IF NOT EXISTS 'T_TicketInfo' ('trainNumber' TEXT,'startStation' TEXT,'startTime' TEXT,'arriveStation' TEXT,'arriveTime' TEXT,'duration' TEXT,'businessPrice' REAL,'firstPrice' REAL,'secondPrice' REAL,'businessCount' INTEGER,'firstCount' INTEGER,'secondCount' INTEGER,'date' TEXT);";
    
    NSString *sqlTrainInfo = @"CREATE TABLE IF NOT EXISTS 'T_TrainInfo' ('station' TEXT,'trainNumber' TEXT,'arriveTime' TEXT, 'startTime' TEXT,'stationOrder' INTEGER,'totalNumber' INTEGER);";
 

    
    NSString *sqlOrderInfo = @"CREATE TABLE IF NOT EXISTS 'T_OrderInfo' ('orderNumber' TEXT NOT NULL,'trainNumber' TEXT,'startStation' TEXT,'startTime' TEXT,'arriveStation' TEXT,'arriveTime' TEXT,'duration' TEXT,'idCardNumber' TEXT ,'name' TEXT,'username' TEXT, 'price' REAL, 'seatClass' TEXT, 'paymentState' TEXT, 'date' TEXT,PRIMARY KEY('orderNumber'));";
    
    [[SqlTool shareinstance] openDatabase:databaseName];
    [[SqlTool shareinstance] createTable:sqlUserINfo];
    [[SqlTool shareinstance] createTable:sqlTicketInfo];
    [[SqlTool shareinstance] createTable:sqlTrainInfo];
    [[SqlTool shareinstance] createTable:sqlOrderInfo];
    [[SqlTool shareinstance] createTable:sqlPersonInfo];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[SqlTool shareinstance] closeDatabse];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
