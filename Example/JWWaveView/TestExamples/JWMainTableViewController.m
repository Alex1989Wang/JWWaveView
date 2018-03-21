//
//  JWMainTableViewController.m
//  JWWaveView
//
//  Created by JiangWang on 21/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWMainTableViewController.h"
#import "JWWaveInCellTestViewController.h"
#import "JWMultiCylceWaveTestViewController.h"

typedef NS_ENUM(NSUInteger, JWWaveViewTestType) {
    JWWaveViewTestTypeMultiCycle,
    JWWaveViewTestTypeInCell,
};

static NSString *JWMainTableViewCellReuseID = @"JWMainTableViewCellReuseID";

@interface JWMainTableViewController ()
@property (nonatomic, strong) NSDictionary *testTypesMap;
@end

@implementation JWMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Wave View Test Examples";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
}

#pragma mark - Private
- (void)setupTableView {
    UITableView *tableView = [self tableView];
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:JWMainTableViewCellReuseID];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testTypesMap.allValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:JWMainTableViewCellReuseID
                                    forIndexPath:indexPath];
    cell.textLabel.text = self.testTypesMap[@(indexPath.row)];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case JWWaveViewTestTypeMultiCycle: {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
            JWMultiCylceWaveTestViewController *testCon =
            [storyboard instantiateViewControllerWithIdentifier:@"JWMultiCylceWaveTestViewController"];
            testCon.title = self.testTypesMap[@(indexPath.row)];
            [self.navigationController pushViewController:testCon animated:YES];
            break;
        }
        case JWWaveViewTestTypeInCell: {
            //put wave view in table cells 
            JWWaveInCellTestViewController *testCon =
            [[JWWaveInCellTestViewController alloc] init];
            testCon.title = self.testTypesMap[@(indexPath.row)];
            [self.navigationController pushViewController:testCon animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Lazy Loading
- (NSDictionary *)testTypesMap {
    if (nil == _testTypesMap) {
        _testTypesMap = @{@(JWWaveViewTestTypeInCell) : @"Wave View In Table Cells",
                          @(JWWaveViewTestTypeMultiCycle) : @"Multiple Wave Cycles",};
    }
    return _testTypesMap;
}

@end
