//
//  AppDelegate.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/9/8.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "AppDelegate.h"
#import "LZFHomeViewController.h"
#import "LZFNavigationController.h"
#import "LZFRootVcPicker.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    
    // 直接进入主界面
    LZFHomeViewController *homeVc = [[LZFHomeViewController alloc] init];
    LZFNavigationController *navVc = [[LZFNavigationController alloc] initWithRootViewController:homeVc];
    self.window.rootViewController = navVc;
    
    // 经过新特性界面在进入主界面
//    self.window.rootViewController = [LZFRootVcPicker chooseRootVcOfWindow];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


/** 允许此App被另一个App通过这个代理方法打开 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    NSLog(@"%@", url.absoluteString); //将url直接转换成字符串的方法
    return YES;
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
