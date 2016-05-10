//
//  WTPieChart.m
//  Wallet
//
//  Created by xiaofeishen on 5/4/16.
//  Copyright © 2016 JohnTsai. All rights reserved.
//

#import "WTPieChart.h"
#import "WTPieChartCore.h"
#import "WTPieChartPiece.h"

const float __beginAngle = M_PI_2; //M_PI为一个半圆，0表示在3点钟位置

@interface WTPieChart ()
<WTPieChartCoreDelegate>
{
    UIView *_indicator;
    CGFloat _total;
    WTPieChartCore *_coreVew;
}
@end

@implementation WTPieChart

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //views
        _coreVew = [[WTPieChartCore alloc] initWithFrame:CGRectZero];
        _coreVew.beignAngle = __beginAngle;
        _coreVew.delegate = self;
        _coreVew.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_coreVew];
        
        _indicator = [[UIView alloc] initWithFrame:CGRectZero];
        _indicator.translatesAutoresizingMaskIntoConstraints = NO;
        _indicator.backgroundColor = [UIColor blackColor];
        [self addSubview:_indicator];

        //layout
        NSMutableArray *cons = @[].mutableCopy;
        NSDictionary *views = NSDictionaryOfVariableBindings(_coreVew,_indicator);
        //--circle
        [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_coreVew]-0-|" options:0 metrics:nil views:views]];
        [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_coreVew]-0-|" options:0 metrics:nil views:views]];
        //--indicator
        [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_indicator(==30)]-(-15)-|" options:0 metrics:nil views:views]];
        [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_indicator(==2)]" options:0 metrics:nil views:views]];
        [cons addObject:[NSLayoutConstraint constraintWithItem:_indicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraints:cons];
    }
    return self;
}

#pragma mark - setter
- (void)setValues:(NSArray<NSNumber *> *)values
{
    if (values.count <= 0) {
        _total = 0;
        return;
    }
    
    NSMutableArray *pieces = [NSMutableArray array];
    _total = 0;
    for (NSNumber *value in values) {
        _total += [value floatValue];
        
        WTPieChartPiece *obj = [[WTPieChartPiece alloc] init];
        obj.value = [value floatValue];
        [pieces addObject:obj];
    };
    
    WTPieChartPiece *pre;
    for (int i = 0; i < pieces.count; i++) {
        WTPieChartPiece *obj = pieces[i];
        if (i == 0) {
            obj.begin = 0; //设置第一个起点值为0刻度
        } else {
            obj.pre = pre;
        }
        obj.delta = [values[i] floatValue]/_total * 2 * M_PI;
        pre = obj;
    }
    _coreVew.pieces = pieces;
}

#pragma mark - delegate
- (void)wtPieChartCore:(WTPieChartCore *)core slideInIndex:(NSInteger)index
{
    [self.delegate wtPieChart:self pointAt:index];
}

@end
