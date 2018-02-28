//
//  AdminUserInfoTableViewController.m
//  FirstTry
//
//  Created by schooldave on 4/21/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "AdminUserInfoTableViewController.h"
#import "UserInfo.h"
#import "UserInfoTableViewCell.h"
#import "SqlTool.h"
@interface AdminUserInfoTableViewController ()

@property (strong, nonatomic) NSArray *allUserInfo;


@end

@implementation AdminUserInfoTableViewController


-(NSArray *)allUserInfo
{
    NSString *searchSql = [NSString stringWithFormat:@"select username, password, name, idCardNumber, phone from T_UserInfo"];
    NSArray *resultArrayDict =[[SqlTool shareinstance] searchData:searchSql andChooseTableNum:0];
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in resultArrayDict) {
        UserInfo *model = [UserInfo userInfoWithDict:dict];
        [arrayModels addObject:model];
    }
    _allUserInfo = arrayModels;
    return _allUserInfo;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allUserInfo.count;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfo *model = self.allUserInfo[indexPath.row];
    static NSString *ID = @"userInfo_cell";
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoTableViewCell" owner:nil options:nil] firstObject];
    }
    cell.userInfo = model;
    return cell;
    
    
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfo *userInfo = self.allUserInfo[indexPath.row];
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM T_UserInfo where username = '%@'",userInfo.username];
    
    //设置注销Alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除用户" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction* refundAction = [UIAlertAction actionWithTitle:@"删除用户" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action ) {
                                                             NSLog(@"hahaha");
                                                             //返回主界面
                                                             [[SqlTool shareinstance] deleteData:deleteSql];
                                                             [self.tableView reloadData];
                                                             
                                                             
                                                         }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action ) {}];
    [alert addAction:refundAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 30.0)];
    // create the button object
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:15];
    headerLabel.frame = CGRectMake(0.0, 10.0, 300.0, 30.0);
    headerLabel.text = [NSString stringWithFormat:@"* 左滑删除用户"];
    [customView addSubview:headerLabel];
    return customView;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除用户";
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
