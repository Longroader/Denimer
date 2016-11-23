//
//  LZFRootVcPicker.m
//  彩票
//
//  Created by LZF on 14/11/11.
//  Copyright © 2014年 longroader. All rights reserved.
//

#import "LZFRootVcPicker.h"
#import "LZFHomeViewController.h"
#import "LZFNewFeatureCollectionViewController.h"
#import "LZFNavigationController.h"
#import "LZFSaveTool.h"

@implementation LZFRootVcPicker

+ (UIViewController *)chooseRootVcOfWindow {
#define LZFVersion @"version"
    
    // 当有版本更新时显示新特性界面
    // 1.获取app当前版本号
    NSString *currVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 2.获取app上次版本号
    NSString *lastVerson = [LZFSaveTool objectForKey:LZFVersion];
    
    UIViewController *rootVc = [[UIViewController alloc] init];
    if (![currVersion isEqualToString:lastVerson]) {
        
        // 进入新特性界面
        rootVc = [[LZFNewFeatureCollectionViewController alloc] init];
        // 存储app当前版本号
        [LZFSaveTool setObject:currVersion forKey:LZFVersion];
    } else {
        
        //直接进入主界面
        LZFHomeViewController *homeVc = [[LZFHomeViewController alloc] init];
        rootVc = [[LZFNavigationController alloc] initWithRootViewController:homeVc];
    }
    
    return rootVc;
}

@end
