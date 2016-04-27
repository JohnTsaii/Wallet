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

// define
#import "WTGlobalMacro.h"

@interface WTHomeViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WTHomeTableViewHeaderView *headerView;

@end

@implementation WTHomeViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
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
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = @"111";
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"最近收支";
}

#pragma mark - event response
- (void)tapHeaderView:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"%s",__func__);
}

#pragma mark - private method

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
