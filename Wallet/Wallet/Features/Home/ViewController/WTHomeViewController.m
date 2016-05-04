//
//  WTHomeViewController.m
//  Wallet
//
//  Created by John TSai on 16/3/23.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#import "WTHomeViewController.h"

// views
#import "WTHomeTableViewHeaderView.h"
#import "WTBalanceRecordCell.h"
#import "WTAccountingViewController.h"

// define
#import "WTGlobalMacro.h"


static NSString *kWTBalanceRecordCellIdentifer = @"kWTBalanceRecordCellIdentifer";

@interface WTHomeViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WTHomeTableViewHeaderView *headerView;

@end

@implementation WTHomeViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[WTBalanceRecordCell class] forCellReuseIdentifier:kWTBalanceRecordCellIdentifer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Delegate & DataSource

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTBalanceRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:kWTBalanceRecordCellIdentifer];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}
- (void)configureCell:(WTBalanceRecordCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell configCell];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"最近收支";
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    tableView.layoutMargins = UIEdgeInsetsZero;
}

#pragma mark - event response
- (void)tapHeaderView:(UIGestureRecognizer *)gestureRecognizer {
    WTAccountingViewController *accountingViewController = [[WTAccountingViewController alloc] init];
    [self.navigationController pushViewController:accountingViewController animated:YES];
}

#pragma mark - private method
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (WTHomeTableViewHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[WTHomeTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, WT_SCREEN_WIDTH, WT_SCREEN_WIDTH * WT_GOLDEN_RATIO)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapHeaderView:)];
        [_headerView addGestureRecognizer:tap];
    }
    
    return _headerView;
}

@end
