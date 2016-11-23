//
//  LZFSaveTool.h
//  彩票
//
//  Created by LZF on 14/11/10.
//  Copyright © 2014年 longroader. All rights reserved.
//  存储工具类

#import <Foundation/Foundation.h>

@interface LZFSaveTool : NSObject
/** 偏好设置:取值 */
+ (nullable id)objectForKey:(NSString * _Nonnull)defaultName;
/** 偏好设置:存值 */
+ (void)setObject:(nullable id)value forKey:( NSString * _Nonnull )defaultName;
@end
