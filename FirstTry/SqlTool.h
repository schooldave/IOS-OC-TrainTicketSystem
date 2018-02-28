//
//  SqlTool.h
//  FirstTry
//
//  Created by schooldave on 3/5/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqlTool : NSObject


- (void)openDatabase:(NSString *)databaseName;
- (void)createTable: (NSString *)createSql;
- (BOOL)insertData: (NSString *)insertSql;
- (void)modifyData: (NSString *)modifySql;
- (void)deleteData: (NSString *)deleteSql;
- (NSMutableArray *)searchData: (NSString *)searchSql andChooseTableNum:(int)tableNum;
- (void)closeDatabse;

+ (SqlTool *)shareinstance;


@end
