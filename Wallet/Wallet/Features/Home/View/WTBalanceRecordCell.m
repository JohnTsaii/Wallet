//
//  WTBalanceRecordCell.m
//  Wallet
//
//  Created by John TSai on 16/4/27.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#import "WTBalanceRecordCell.h"

@interface WTBalanceRecordCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *remark;
@property (nonatomic, strong) UILabel *amount;
@property (nonatomic, strong) UILabel *date;

@end

@implementation WTBalanceRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarImageView.layer.cornerRadius = CGRectGetWidth(self.avatarImageView.frame) / 2.0;
    self.avatarImageView.layer.masksToBounds = YES;
}

- (void)setUp {
    
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.type];
    [self.contentView addSubview:self.remark];
    [self.contentView addSubview:self.amount];
    [self.contentView addSubview:self.date];
    
    
    NSDictionary *views = @{
                            @"avatarImageView": self.avatarImageView,
                            @"type": self.type,
                            @"remark": self.remark,
                            @"amount": self.amount,
                            @"date": self.date,
                            };
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[avatarImageView]-[type]->=8-[amount]-|"
                                                                             options:NSLayoutFormatAlignAllTop
                                                                             metrics:nil
                                                                               views:views]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[avatarImageView]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[type]->=5-[remark]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[amount]->=5-[date]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.avatarImageView
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:1.0
                                                                  constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[avatarImageView]-[remark]->=8-[date]-|"
                                                                             options:NSLayoutFormatAlignAllBottom
                                                                             metrics:nil
                                                                               views:views]];
}

#pragma mark - ConfigCell
- (void)configCell {
    self.avatarImageView.image = [UIImage imageNamed:@"global_default_avatar"];
    self.type.text = @"食品";
    self.remark.text = @"吃晚饭";
    self.amount.text = @"￥15.0";
    self.date.text = @"11-11 11:11";
    
    [self layoutIfNeeded];
    
}

#pragma mark - getters
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _avatarImageView.layer.cornerRadius = CGRectGetWidth(self.avatarImageView.frame) / 2.0;
        _avatarImageView.layer.masksToBounds = YES;
    }
    
    return _avatarImageView;
}

- (UILabel *)type {
    if (!_type) {
        _type = [[UILabel alloc] init];
        _type.font = [UIFont systemFontOfSize:14.0f];
        _type.textColor = [UIColor blackColor];
        _type.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _type;
}

- (UILabel *)remark {
    if (!_remark) {
        _remark = [[UILabel alloc] init];
        _remark.font = [UIFont systemFontOfSize:13.0f];
        _remark.textColor = [UIColor lightGrayColor];
        _remark.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _remark;
}

- (UILabel *)amount {
    if (!_amount) {
        _amount = [[UILabel alloc] init];
        _amount.font = [UIFont systemFontOfSize:14.0f];
        _amount.textColor = [UIColor blackColor];
        _amount.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _amount;
}

- (UILabel *)date {
    if (!_date) {
        _date = [[UILabel alloc] init];
        _date.font = [UIFont systemFontOfSize:13.0f];
        _date.textColor = [UIColor lightGrayColor];
        _date.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _date;
}


@end
