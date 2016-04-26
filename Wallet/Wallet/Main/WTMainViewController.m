//
//  WTMainViewController.m
//  Wallet
//
//  Created by John TSai on 16/3/23.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#import "WTMainViewController.h"

// view controllers
#import "WTChartViewControler.h"
#import "WTHomeViewController.h"
#import "WTPersoanlViewController.h"

@interface WTMainViewController ()

@property (nonatomic, strong) WTHomeViewController *homeViewController;
@property (nonatomic, strong) WTChartViewControler *chartViewController;
@property (nonatomic, strong) WTPersoanlViewController *personalViewController;

@property (nonatomic, strong) UINavigationController *homeNavigationController;
@property (nonatomic, strong) UINavigationController *chartNavigationController;
@property (nonatomic, strong) UINavigationController *personalNavigationController;

@end

@implementation WTMainViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.viewControllers = @[self.homeNavigationController, self.chartNavigationController, self.personalNavigationController];
    
    self.homeNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"收支"
                                                                             image:[UIImage imageNamed:@"account_select"]
                                                                     selectedImage:[UIImage imageNamed:@"account_selected"]];
    
    self.chartNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"图表"
                                                                             image:[UIImage imageNamed:@"chart_select"]
                                                                     selectedImage:[UIImage imageNamed:@"chart_selected"]];
    
    self.personalNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人"
                                                                             image:[UIImage imageNamed:@"profile_select"]
                                                                     selectedImage:[UIImage imageNamed:@"profile_selected"]];
    
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

#pragma mark - Init
- (UIViewController *)homeViewController {
    if (!_homeViewController) {
        _homeViewController = [[WTHomeViewController alloc] init];
    }
    
    return _homeViewController;
}

- (UIViewController *)chartViewController {
    if (!_chartViewController) {
        _chartViewController = [[WTChartViewControler alloc] init];
    }
    return _chartViewController;
}

- (UIViewController *)personalViewController {
    if (!_personalViewController) {
        _personalViewController = [[WTPersoanlViewController alloc] init];
    }
    
    return _personalViewController;
}

- (UINavigationController *)homeNavigationController {
    if (!_homeNavigationController) {
        _homeNavigationController = [self createNavigationControllerWithRootViewController:self.homeViewController];
    }
    
    return _homeNavigationController;
}

- (UINavigationController *)chartNavigationController {
    if (!_chartNavigationController) {
        _chartNavigationController = [self createNavigationControllerWithRootViewController:self.chartViewController];
    }
    
    return _chartNavigationController;
}

- (UINavigationController *)personalNavigationController {
    if (!_personalNavigationController) {
        _personalNavigationController = [self createNavigationControllerWithRootViewController:self.personalViewController];
    }
    
    return _personalNavigationController;
}

#pragma mark - Init NavigationBar

- (UINavigationController *)createNavigationControllerWithRootViewController:(UIViewController *)vc {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}


@end
