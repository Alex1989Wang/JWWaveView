//
//  JWWaveInCellTestViewController.m
//  JWWaveView
//
//  Created by JiangWang on 18/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWWaveInCellTestViewController.h"
#import "JWWaveTableCell.h"

static NSString *const kWaveTableCellReuseID = @"jiangwang.com.waveTableCellReuseID";

@interface JWWaveInCellTestViewController ()

@end

@implementation JWWaveInCellTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Wave View In Table Cells";
    
    //prepare table
    [self.tableView registerClass:[JWWaveTableCell class]
           forCellReuseIdentifier:kWaveTableCellReuseID];
    self.tableView.estimatedRowHeight = 0.f;
    self.tableView.estimatedSectionFooterHeight = 0.f;
    self.tableView.estimatedSectionHeaderHeight = 0.f;
    self.tableView.rowHeight = kJWTableCellHeight;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JWWaveTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kWaveTableCellReuseID];
    cell.textLabel.text = [NSString stringWithFormat:@"row %ld, section %ld",
                           indexPath.row, indexPath.section];
    cell.imageView.image = [UIImage imageNamed:@"gift_icon"];
    return cell;
}

@end
