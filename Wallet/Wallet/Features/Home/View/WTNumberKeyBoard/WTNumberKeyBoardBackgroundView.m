//
//  WTNumberKeyBoardBackgroundView.m
//  Wallet
//
//  Created by John TSai on 16/5/3.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#import "WTNumberKeyBoardBackgroundView.h"
#import "WTNumberKeyBoardContainerView.h"

@interface WTNumberKeyBoardBackgroundView ()

@property (nonatomic, weak) WTNumberKeyBoardContainerView *containerView;

@end

@implementation WTNumberKeyBoardBackgroundView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    WTNumberKeyBoardContainerView *containerView = [[WTNumberKeyBoardContainerView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    
    self.backgroundColor = [UIColor redColor];
    self.containerView = containerView;
    [self addSubview:self.containerView];
}

- (void)layoutSubviews {
    self.containerView.frame = self.bounds;
}

@end
