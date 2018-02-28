//
//  CitySearchViewController.m
//  FirstTry
//
//  Created by schooldave on 3/13/17.
//  Copyright © 2017 schooldave. All rights reserved.
//

#import "CitySearchViewController.h"

NSMutableArray *recentArray;
NSArray *allStationArray;
NSArray *resultStationArray;
UISearchController *searchController;
UISearchBar* searchBar;

@interface CitySearchViewController () <UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *stationShowTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


@property (nonatomic, strong) NSArray *groups;
@end

@implementation CitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    resultStationArray = [NSArray array];
//    recentArray = [NSMutableArray array];
    allStationArray = [NSArray arrayWithObjects:@"安庆",@"安庆西",@"北京",@"北京南",@"南京",@"南京南",@"上海",@"上海虹桥",@"宁德",@"惠安",@"福州",@"福州南",@"厦门",@"厦门北",@"xm",@"xmb",nil];
   
    
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchBar.placeholder = @"请输入车站名";
    searchController.searchBar.delegate = self;
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext=YES;
    [self.segmentedControl addTarget:self action:@selector(segmentedChange) forControlEvents:UIControlEventValueChanged];
    self.stationShowTableView.dataSource = self;
    self.stationShowTableView.delegate = self;

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    recentArray = [NSMutableArray arrayWithArray:[ud objectForKey:@"preferStation"]];
    
    // Do any additional setup after loading the view.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedCity;
    int flag = 0;
    Station *station = self.groups[indexPath.section];
    if (searchController.active) {
       selectedCity = resultStationArray[indexPath.row];
    } else {
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            selectedCity = recentArray[indexPath.row];
            
        } else {
            selectedCity = station.station[indexPath.row];
            
        }
      
    }
    NSLog(@"selected-----%@",selectedCity);
    if ([self.delegate respondsToSelector:@selector(citySelectedViewController:withCity:andIsStart:)]) {
        if (self.isStart) {
             [self.delegate citySelectedViewController:self withCity:selectedCity andIsStart:YES];
        } else [self.delegate citySelectedViewController:self withCity:selectedCity andIsStart:NO];

    }
    for (NSString *station in recentArray) {
        if ([station isEqualToString:selectedCity]) {
            flag++;
        }
    }
    if ( !flag) {
        [recentArray addObject:selectedCity];
        
    } else flag = 0;

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:recentArray forKey:@"preferStation"];
    [ud synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

//懒加载数据
-(NSArray *)groups
{
    if (_groups == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Stations.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            Station *model = [Station stationWithDict:dict];
            [arrayModels addObject:model];
        }
        _groups = arrayModels;
    }
    return _groups;
}

- (void)segmentedChange
{
    [self.stationShowTableView reloadData];
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        self.stationShowTableView.tableHeaderView = searchController.searchBar;
        [searchController.searchBar sizeToFit];
        searchController.searchBar.hidden = NO;
    } else {
        searchController.searchBar.hidden = YES;
        self.stationShowTableView.tableHeaderView = nil;
    }
    
}

#pragma mark - Search method
/**点击按钮后，进行搜索页更新*/
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:searchController];
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"updateSearchResultsForSearchController --> ");
    NSMutableArray *searchResult=[[NSMutableArray alloc]init];
    for (NSString *station in allStationArray) {
        //        NSLog(@"%@",station);
        NSRange range=[station rangeOfString:searchController.searchBar.text];
        if (range.length>0 ) {
            [searchResult addObject:station];
        }
        
    }
    resultStationArray = searchResult;
    // 刷新数据（显示新数组）
    [self.stationShowTableView reloadData];
}

#pragma mark - Table view data source
// How many section.
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.segmentedControl.selectedSegmentIndex == 0 || searchController.active) {
        return 1;
    } else {
        return self.groups.count;
    }
}

// How many cell per group have.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (searchController.active) {
        return [resultStationArray count];
    } else {
        if (self.segmentedControl.selectedSegmentIndex == 0) {
//            NSLog(@"%lu",(unsigned long)recentArray.count);
            return recentArray.count;
        } else {
            Station *station = self.groups[section];
            return station.station.count;
        }
    }
    
}
//what to show in cell.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取模型数据
    Station *station = self.groups[indexPath.section];
    //创建单元格
    //声明一个重用ID
    static NSString *ID = @"station_cell";
    //根据重用ID去缓存池中获取对应的cell对象
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果没有获取到，就创建一个
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //设置单元格内容
    if (searchController.active) {
        cell.textLabel.text = resultStationArray[indexPath.row];
    } else {
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            cell.textLabel.text = recentArray[indexPath.row];
            
        } else {
            cell.textLabel.text = station.station[indexPath.row];

        }
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex == 0 || searchController.active) {
        return nil;
    } else {
        Station *station = self.groups[section];
        return station.title;
    }
    
}

//设置UITableView右侧的索引栏
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return nil;
    } else {
        NSMutableArray *arrayIndex = [NSMutableArray array];
        for (Station *station in self.groups) {
            [arrayIndex addObject: station.title];
        }
        return arrayIndex;
    }
}


@end
