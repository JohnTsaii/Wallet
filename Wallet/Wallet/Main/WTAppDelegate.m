//
//  AppDelegate.m
//  Wallet
//
//  Created by John TSai on 16/3/22.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#import "WTAppDelegate.h"
#import "WTMainViewController.h"
#import <FMDB/FMDB.h>

@interface WTAppDelegate ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation WTAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //--data base---
    [self initDatabase];
    [self createTable];
    //----
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[WTMainViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)initDatabase
{
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]; //数据库路径
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"main.db"];
    self.db = [FMDatabase databaseWithPath:dbPath];
    if (![self.db open]) {
        DLog(@"db open error!");
    }
    [self.db setShouldCacheStatements:YES];//缓存，提高查询效率
}

- (void)createTable
{
    NSString *sql = @"create table if not exists 'TWRecord' (mId integer primary key autoincrement not null,\
    money float not null default 0,\
    date double not null default 0,\
    desc text not null default '',\
    category_id integer not null default 0,\
    categoryName text not null default '');"
    "create table if not exists 'TWCategorys' (mId integer primary key autoincrement not null,\
    name text not null default '');";
    
    [self.db executeStatements:sql];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
