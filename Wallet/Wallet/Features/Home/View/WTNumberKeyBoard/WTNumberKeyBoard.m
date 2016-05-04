//
//  WTNumberKeyBoard.m
//  Wallet
//
//  Created by John TSai on 16/5/3.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#import "WTNumberKeyBoard.h"
#import "WTNumberKeyBoardBackgroundView.h"

@implementation WTNumberKeyBoard

- (CGSize)intrinsicContentSize {
    return CGSizeMake(320, 200);
}


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
    WTNumberKeyBoardBackgroundView *backgroundView = [[WTNumberKeyBoardBackgroundView alloc] init];
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:backgroundView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(backgroundView);
    
    // add constraints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundView]|"
                                                               options:0
                                                               metrics:nil
                                                                 views:views]];
    
    // add constraints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

@end

