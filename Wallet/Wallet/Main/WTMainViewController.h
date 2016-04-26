//
//  WTMainViewController.h
//  Wallet
//
//  Created by John TSai on 16/3/23.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTHomeViewController;
@class WTChartViewControler;
@class WTPersoanlViewController;

@interface WTMainViewController : UITabBarController

@property (nonatomic, strong, readonly) WTHomeViewController *homeViewController;
@property (nonatomic, strong, readonly) WTChartViewControler *chartViewController;
@property (nonatomic, strong, readonly) WTPersoanlViewController *personalViewController;

@end
