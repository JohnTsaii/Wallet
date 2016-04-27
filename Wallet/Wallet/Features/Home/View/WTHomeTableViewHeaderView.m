//
//  WTHomeTableViewHeaderView.m
//  Wallet
//
//  Created by John TSai on 16/4/27.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#import "WTHomeTableViewHeaderView.h"
#import "Mediator.h"
#import <UICountingLabel/UICountingLabel.h>

@interface WTHomeTableViewHeaderView ()

@property (nonatomic, strong) UICountingLabel *countLabel;
@property (nonatomic, strong) UILabel *remindLabel;

@end

@implementation WTHomeTableViewHeaderView

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

- (CGSize)intrinsicContentSize {
    return CGSizeMake(WT_SCREEN_WIDTH, WT_SCREEN_WIDTH * WT_GOLDEN_RATIO);
}

#pragma mark - set up
- (void)setUp {
    [self addSubview:self.countLabel];
    [self addSubview:self.remindLabel];
    
    NSDictionary *views = @{
                            @"countLabel": self.countLabel,
                            @"remindLabel": self.remindLabel
                            };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[countLabel]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[countLabel]-20-[remindLabel]"
                                                                 options:NSLayoutFormatAlignAllLeading|NSLayoutFormatAlignAllTrailing
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.countLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    
    // default value
    [self setCount:1000];
    [self setRemindText:@"点击记账"];
    
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UICountingLabel alloc] init];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = WT_DECIMAL_FONT_SIZE(40.0f);
        _countLabel.textColor = [UIColor lightGrayColor];
        _countLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    }
    return _countLabel;
}

- (UILabel *)remindLabel {
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.font = [UIFont systemFontOfSize:13.0f];
        _remindLabel.textColor = [UIColor grayColor];
        _remindLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _remindLabel;
}


#pragma mark - Setters

- (void)setCount:(CGFloat)count {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    
    self.countLabel.text = [formatter stringFromNumber:[NSNumber numberWithFloat:count]];
    
    
    [self.countLabel countFromCurrentValueTo:count];
    
    self.countLabel.attributedFormatBlock = ^NSAttributedString* (CGFloat value) {
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSFontAttributeName: [UIFont systemFontOfSize:20.0f]
                                  };
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%0.2f", value]];
        [attributeString setAttributes:attribs range:NSMakeRange(0, 1)];
        return attributeString;
    };
}

- (void)setRemindText:(NSString *)remindText {
    self.remindLabel.text = remindText;
}

@end
