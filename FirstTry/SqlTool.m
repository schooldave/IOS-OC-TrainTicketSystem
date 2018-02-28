//
//  SqlTool.m
//  FirstTry
//
//  Created by schooldave on 3/5/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "SqlTool.h"

@implementation SqlTool

{
    //数据库对象地址存储
    sqlite3 *database;
    char * error;
}


-(void)openDatabase:(NSString *)databaseName
{
    
    NSString *databaseFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)[0] stringByAppendingPathComponent:databaseName];
    
    if (sqlite3_open([databaseFilePath UTF8String], &database) == SQLITE_OK) {
        NSLog(@"sqlite database is opened.");
        NSLog(@"%@",databaseFilePath);
    } else {
        NSLog(@"sqlite databse opened fail.");
    }
    
    
}

- (void)createTable:(NSString *)createSql
{
    if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &error) == SQLITE_OK) {
        NSLog(@"The table is already exist");
    } else {
        NSLog(@"The table can not be created!!");
    }
     sqlite3_free(error);
}



- (BOOL)insertData: (NSString *)insertSql
{
//    NSString *insertSql = [NSString stringWithFormat:@"insert into T_UserInfo(username,password,name,idCardNumber,phone,ticketCount) values('%@', '%@', '%@', '%@','%@','0');",self.usernameField.text,self.passwordFieldFirst.text,self.nameField.text,self.idCardNumberField.text,self.phoneField.text];
    
    if (sqlite3_exec(database, [insertSql UTF8String], NULL, NULL, &error) == SQLITE_OK) {
        NSLog(@"insert operation done.");
        return YES;
    } else {
        NSLog(@"error: %s", error);
        
        // 每次使用完毕清空 error 字符串，提供给下一次使用
        sqlite3_free(error);
        return NO;
    }
    
}


- (void)modifyData: (NSString *)modifySql
{
    
    //    NSString *modifySql = [NSString stringWithFormat:@"update 'T_UserInfo' set name = '%@',password = '%@',identityCardNumber = '%@' where username = 'schooldave'",self.nameField.text,self.passwordField.text,self.idNumberField.text];
    if (sqlite3_exec(database, [modifySql UTF8String], NULL, NULL, &error) == SQLITE_OK) {
        NSLog(@"update operation is ok.");
    } else {
        NSLog(@"error: %s", error);
        
        // 每次使用完毕清空 error 字符串，提供给下一次使用
        sqlite3_free(error);
    }
    
    
}

-(void)deleteData:(NSString *)deleteSql
{

//    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM T_UserInfo "];
    if(sqlite3_exec(database, [deleteSql UTF8String], NULL, NULL, &error) == SQLITE_OK  )
    {
        NSLog(@"delete data successfully");
    }else{
        NSLog(@"error: %s", error);
    }
    sqlite3_free(error);

}

- (NSMutableArray *)searchData: (NSString *)searchSql andChooseTableNum:(int)tableNum
{
    
    //  NSString *searchSql = @"select username,password,name,idCardNumber,phone from T_UserInfo where username = 'schooldave'";
    
    //可变数组存放dict
    NSMutableArray *resultArray = [NSMutableArray array];
  
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(database, [searchSql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        while(sqlite3_step(statement) == SQLITE_ROW) {
            //可变字典存放每一条数据 主key为username
            NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
            if (tableNum == 0) {
                //T_UserInfo 属性：username, password, name, idCardNumber, phone, ticketCount
                
                // 查询 usernmae 的值
                NSString *username = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                NSString *password = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                
                NSString *idCardNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];

                //T_UserInfo 属性：username, password, name, idCardNumber, phone, ticketCount
                
//                NSLog(@"username:%@, name:%@,password:%@,identityCardNumber:%@",username,name,password,idCardNumber);
                [resultDict setObject:username forKey:@"username"];
                [resultDict setObject:password forKey:@"password"];
                [resultDict setObject:name forKey:@"name"];
                [resultDict setObject:idCardNumber forKey:@"idCardNumber"];
                [resultDict setObject:phone forKey:@"phone"];
                
            } else if(tableNum == 1) {
                
                
                // 查询 trainNumber 的值
                NSString *trainNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];

                NSString *startStation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];

                NSString *startTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                
                NSString *arriveStation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                NSString *arriveTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                
                NSString *duration = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                
                double businessPrice = sqlite3_column_double(statement, 6);

                double firstPrice = sqlite3_column_double(statement, 7);

                double secondPrice = sqlite3_column_double(statement, 8);
                
                int businessCount = sqlite3_column_int(statement, 9);
                
                int firstCount = sqlite3_column_int(statement, 10);
                
                int secondCount = sqlite3_column_int(statement, 11);
                
                NSString *date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];

                //T_TicketInfo
                //trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date
//                NSLog(@"trainNumber %@, startStation %@, startTime %@, arriveStation %@, arriveTime %@, duration %@, businessPrice %lf,firstPrice %lf,secondPrice %lf,businessCount %d,firstCount %d,secondCount %d, date %@", trainNumber,startStation,startTime,arriveStation,arriveTime,duration,businessPrice,firstPrice,secondPrice,businessCount,firstCount,secondCount,date);
                
                [resultDict setObject:trainNumber forKey:@"trainNumber"];
                [resultDict setObject:startStation forKey:@"startStation"];
                [resultDict setObject:startTime forKey:@"startTime"];
                [resultDict setObject:arriveStation forKey:@"arriveStation"];
                [resultDict setObject:arriveTime forKey:@"arriveTime"];
                [resultDict setObject:duration forKey:@"duration"];

                [resultDict setObject:@(businessPrice) forKey:@"businessPrice"];
                [resultDict setObject:@(firstPrice) forKey:@"firstPrice"];
                [resultDict setObject:@(secondPrice) forKey:@"secondPrice"];
                [resultDict setObject:@(businessCount) forKey:@"businessCount"];
                [resultDict setObject:@(firstCount) forKey:@"firstCount"];
                [resultDict setObject:@(secondCount) forKey:@"secondCount"];

                [resultDict setObject:date forKey:@"date"];
                
            } else if (tableNum == 2) {
                
                //T_TrainInfo
                //station,trainNumber,arriveTime,startTime,stationOrder,totalNumber
                
                // 查询 station 的值
                NSString *station = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];

                //查询trainNumber 的值
                NSString *trainNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                
                // 查询 arriveTime 的值
                NSString *arriveTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                
                // 查询 startTime 的值
                NSString *startTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                int stationOrder = sqlite3_column_int(statement, 4);
//                NSNumber *stationOrderNS = [NSNumber numberWithInt:stationOrder];
                
                int totalNumber = sqlite3_column_int(statement, 5);
//                NSNumber *totalNumberNS = [NSNumber numberWithInt:totalNumber];
                
//                NSLog(@"station %@, trainNumber %@, arriveTime %@, startTime %@, stationOrder %d, totalNumber %d", station,trainNumber,arriveTime,startTime,stationOrder,totalNumber);
                [resultDict setObject:station forKey:@"station"];
                [resultDict setObject:trainNumber forKey:@"trainNumber"];
                [resultDict setObject:arriveTime forKey:@"arriveTime"];
                [resultDict setObject:startTime forKey:@"startTime"];
                [resultDict setObject:@(stationOrder) forKey:@"stationOrder"];
                [resultDict setObject:@(totalNumber) forKey:@"totalNumber"];
                
            } else if (tableNum == 3) {
                //T_PersonInfo
                //name,idCardNumber,username;
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *idCardNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *username = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                
//                NSLog(@"name %@, idCardNumber %@, username %@", name, idCardNumber, username);
                [resultDict setObject:name forKey:@"name"];
                [resultDict setObject:idCardNumber forKey:@"idCardNumber"];
                [resultDict setObject:username forKey:@"username"];
                
            } else if (tableNum == 4) {
//                T_OrderInfo
                //orderNumber,trainNumber,startStation,startTime,arriveStation,arriveTime,duration,idCardNumber,name,username,price,seatClass, paymentState,date
                NSString *orderNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                NSString *trainNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                
                NSString *startStation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                
                NSString *startTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                NSString *arriveStation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                
                NSString *arriveTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                
                NSString *duration = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                
                NSString *idCardNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                
                NSString *username = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                
                double price = sqlite3_column_double(statement, 10);
                
                NSString *seatClass = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
                
                NSString *paymentState = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
                
                NSString *date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];

                
                [resultDict setObject:orderNumber forKey:@"orderNumber"];
                [resultDict setObject:trainNumber forKey:@"trainNumber"];
                [resultDict setObject:startStation forKey:@"startStation"];
                [resultDict setObject:startTime forKey:@"startTime"];
                [resultDict setObject:arriveStation forKey:@"arriveStation"];
                [resultDict setObject:arriveTime forKey:@"arriveTime"];
                [resultDict setObject:duration forKey:@"duration"];
                [resultDict setObject:idCardNumber forKey:@"idCardNumber"];
                [resultDict setObject:name forKey:@"name"];
                [resultDict setObject:username forKey:@"username"];
                [resultDict setObject:@(price) forKey:@"price"];
                [resultDict setObject:seatClass forKey:@"seatClass"];
                [resultDict setObject:paymentState forKey:@"paymentState"];
                [resultDict setObject:date forKey:@"date"];
            }
            
//            NSLog(@"%@",resultDict);
            //将当前查询到符合条件的一条数据以dict形式存入数组
            [resultArray addObject:resultDict];
        }
    } else {
        NSLog(@"search operation is fail.");
    }
//    NSLog(@"found..........%lu",(unsigned long)resultArray.count);
    sqlite3_finalize(statement);
    return resultArray;
}     

//关闭数据库
-(void)closeDatabse
{
    if (sqlite3_close(database) == SQLITE_OK) {
        NSLog(@"database closed.");
    } else {
        NSLog(@"databse closed fail");
        sqlite3_close(database);
    }
}


//创建类方法 实例
+ (SqlTool *)shareinstance
{
    static SqlTool *sql= nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sql = [[SqlTool alloc] init];
    });
    
    return sql;

}

@end
