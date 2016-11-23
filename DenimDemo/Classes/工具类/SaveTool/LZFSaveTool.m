//
//  LZFSaveTool.m
//  彩票
//
//  Created by LZF on 14/11/10.
//  Copyright © 2014年 longroader. All rights reserved.
//

#import "LZFSaveTool.h"

@implementation LZFSaveTool

+ (nullable id)objectForKey:(NSString * _Nonnull)defaultName {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(nullable id)value forKey:(NSString * _Nonnull)defaultName {
    
    if (defaultName) { // 屏蔽key为nil的情况,传nil程序会挂
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
        [[NSUserDefaults standardUserDefaults] synchronize]; // 同步数据
    }
}

@end
