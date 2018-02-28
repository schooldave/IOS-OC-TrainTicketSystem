//
//  AddPassengerTableViewController.m
//  FirstTry
//
//  Created by schooldave on 4/12/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "AddPassengerTableViewController.h"
@interface AddPassengerTableViewController ()<UITableViewDataSource,UITableViewDelegate,addPersonTableViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *allPersonInfo;

@end

NSMutableArray *selectedArray;

@implementation AddPassengerTableViewController

-(NSMutableArray *)allPersonInfo
{
    NSLog(@"11111");
    NSString *searchSql = [NSString stringWithFormat:@"select name, idCardNumber, username from T_PersonInfo where username = '%@'",self.username];
    NSMutableArray *resultArray = [[SqlTool shareinstance] searchData:searchSql andChooseTableNum:3];
    _allPersonInfo = resultArray;
    NSLog(@"000000%lu",(unsigned long)resultArray.count);
    return _allPersonInfo;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }else  return self.allPersonInfo.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"personInfo_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.section == 1) {

            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:@"确定" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"okButton_1"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"okButton_2"] forState:UIControlStateHighlighted];
            [button sizeToFit];
            [button addTarget:self action:@selector(confirmChoice) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
            button.frame = CGRectMake(-40, 0, 400, 48);

    }
    if (indexPath.section == 0){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.textLabel.text = self.allPersonInfo[indexPath.row][@"name"];
        cell.detailTextLabel.text = self.allPersonInfo[indexPath.row][@"idCardNumber"];
    }
    return cell;
}

- (void)confirmChoice
{
    NSLog(@"ddd");
    if ( [self.delegate respondsToSelector:@selector(addPassengerTableViewController: andPassenger:)] ) {
        [self.delegate addPassengerTableViewController:self andPassenger:selectedArray];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [selectedArray addObject:self.allPersonInfo[indexPath.row]];
    NSLog(@"0.0.0.%lu",(unsigned long)selectedArray.count);
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [selectedArray removeObject:self.allPersonInfo[indexPath.row]];
    NSLog(@"1.1.1.00%lu",(unsigned long)selectedArray.count);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section == 0) {
        return YES;
    }
    return NO;
    
}




- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        return 48;
    } else return 44;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAddPerson"]) {
        AddPersonTableViewController *addPerson = segue.destinationViewController;
        addPerson.username = self.username;
        addPerson.delegate = self;
    }

}

-(void)addPersonTableViewController:(AddPersonTableViewController *)addPersonTableViewController
{
    NSLog(@"2222.1.00%lu",(unsigned long)selectedArray.count);
    [selectedArray removeAllObjects];
    [self.tableView reloadData];
//    [self.tableView reloadSections: [NSIndexSet indexSetWithIndex:0]  withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.allPersonInfo.count-1 inSection:0]]  withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     selectedArray = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.editing = YES;
//self.tableView.allowsMultipleSelectionDuringEditing = YES;
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
