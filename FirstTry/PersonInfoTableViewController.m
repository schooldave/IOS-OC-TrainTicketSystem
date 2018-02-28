//
//  PersonInfoTableViewController.m
//  FirstTry
//
//  Created by schooldave on 4/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "PersonInfoTableViewController.h"

@interface PersonInfoTableViewController ()<UITableViewDataSource,UITableViewDelegate,addPersonTableViewControllerDelegate,modifyPersonInfoTableViewControllerDelegate>
@property (nonatomic, strong) NSArray *allPersonInfo;
@end

@implementation PersonInfoTableViewController

-(NSArray *)allPersonInfo
{
    NSLog(@"11111");
    NSString *searchSql = [NSString stringWithFormat:@"select name, idCardNumber, username from T_PersonInfo where username = '%@'",self.username];
    NSArray *resultArray = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:3];

    _allPersonInfo = resultArray;
    return _allPersonInfo;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allPersonInfo.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"personInfo_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TrainInfo" owner:nil options:nil] firstObject];
    }
    cell.textLabel.text = self.allPersonInfo[indexPath.row][@"name"];
    cell.detailTextLabel.text = self.allPersonInfo[indexPath.row][@"idCardNumber"];
    return cell;
}

//让tableView 进入编辑模式
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM T_PersonInfo where idCardNumber = '%@' and username = '%@'",self.allPersonInfo[indexPath.row][@"idCardNumber"],self.username];
    [[SqlTool shareinstance] deleteData:deleteSql];   
    [self.tableView reloadData];
//    [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
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
    headerLabel.frame = CGRectMake(15.0, 10.0, 300.0, 30.0);
    headerLabel.text = [NSString stringWithFormat:@"* 左滑删除联系人"];
    [customView addSubview:headerLabel];
    return customView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    if (section == 1 ) {
    //        return 20;
    //    } else return 0;
    return 40;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAddPersonInfo"]) {
        AddPersonTableViewController *addPerson = segue.destinationViewController;
        addPerson.username = self.username;
        addPerson.delegate = self;
//        addPerson.tableView.delegate = self;
    } else if ( [segue.identifier isEqualToString:@"toModifyPersonInfo"]) {
        ModifyPersonInfoTableViewController *modifyPerson = segue.destinationViewController;
        modifyPerson.delegate = self;
        NSIndexPath *path =  [self.tableView indexPathForSelectedRow];
        modifyPerson.idCardNumber = self.allPersonInfo[path.row][@"idCardNumber"];
        modifyPerson.username = self.allPersonInfo[path.row][@"username"];
        modifyPerson.name = self.allPersonInfo[path.row][@"name"];
    }
}

-(void)addPersonTableViewController:(AddPersonTableViewController *)addPersonTableViewController
{
    [self.tableView reloadData];
}

-(void)modifyPersonInfoTableViewController:(ModifyPersonInfoTableViewController *)modifyPersonInfoTableView
{
    [self.tableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
//    self.tableView.tableFooterView = [[UIView alloc]init];

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
