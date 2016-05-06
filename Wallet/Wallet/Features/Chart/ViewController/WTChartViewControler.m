//
//  WTChartViewControler.m
//  Wallet
//
//  Created by John TSai on 16/3/23.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#import "WTChartViewControler.h"
#import "WTPieChart.h"

@interface WTChartViewControler ()
{
    WTPieChart *_chart;
    NSArray *_dataSource;
}
@end

@implementation WTChartViewControler

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //views
    _chart = [[WTPieChart alloc] initWithFrame:CGRectZero];
    [_chart setValues:@[@(130),@(120),@(100),@(80),@(30)]];
    _chart.backgroundColor = [UIColor whiteColor];
    _chart.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_chart];
    
    //layout
    NSDictionary *views = NSDictionaryOfVariableBindings(_chart);
    NSArray *hCons = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_chart]-|" options:0 metrics:nil views:views];
    NSArray *vCons = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_chart]" options:0 metrics:nil views:views];
    [self.view addConstraints:hCons];
    [self.view addConstraints:vCons];
    NSLayoutConstraint *w2hCon = [NSLayoutConstraint constraintWithItem:_chart attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_chart attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [_chart addConstraint:w2hCon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
