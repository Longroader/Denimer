//
//  LZFClearCacheCell.m
//  百思不得姐练习
//
//  Created by 刘志锋 on 16/6/23.
//  Copyright © 2016年 longroader. All rights reserved.
//  自定义清除缓存cell，拖走可用

#import "LZFClearCacheCell.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

#define LZFCustomCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"]

@implementation LZFClearCacheCell

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 1.cell基本设置
        self.textLabel.text = @"清除缓存(缓存计算中..)";
        self.textLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 2.设置cell右边的指示器(提示用户此cell正在处理一些事情)
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        // 3.在缓存计算完成之前禁止cell的点击事件
        self.userInteractionEnabled = NO;
        
        // 这句代码等同于下面那句
        //////// __weak LZFClearCacheCell *weakSelf = self;
        //////// typeof(self)的意思是判断一下自己的类型
        __weak typeof(self) weakSelf = self;////////////////弱引用，以便随时销毁
        
        // 在子线程计算缓存大小
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
#warning 睡眠
            [NSThread sleepForTimeInterval:3.0];
            
            // 1.获得缓存文件夹路径
            unsigned long long size = LZFCustomCacheFile.fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            
            // 如果用户提前点击了设置界面的返回按钮，即销毁了cell，就直接返回，不再往下执行代码
            if (weakSelf == nil) return;
            
            // 判断缓存大小设置相应的显示单位(GB/MG/KB/B)
            NSString *sizeText = nil;
            if (size >= pow(10, 9)) { 
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) {
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) {
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else {
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            // 2.生成文字
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)", sizeText];
            
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置文字
                weakSelf.textLabel.text = text;
                // 清空右边的指示器
                weakSelf.accessoryView = nil;
                // 显示右边的箭头
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                // 添加手势监听器
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
                // 恢复cell的点击事件
                weakSelf.userInteractionEnabled = YES;
            });
        });
    }
    return self;
}

#pragma mark - 布局子控件
/**
 *  当cell重新显示到屏幕上时，也会调用一次layoutSubviews
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 清除缓存cell重新显示时，让右边继续转圈圈
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    
    [loadingView startAnimating];
}

#pragma mark - 清除缓存
- (void)clearCache
{
    // 利用第三方框架弹出提示框
    [SVProgressHUD showWithStatus:@"缓存清除中.."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 清除SDWebImage缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
        // 删除自定义目录缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:LZFCustomCacheFile error:nil];
            [mgr createDirectoryAtPath:LZFCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
#warning 睡眠
            [NSThread sleepForTimeInterval:2.0];
            // 回到主线程删除指示器
            dispatch_async(dispatch_get_main_queue(), ^{
                // 隐藏指示器
                [SVProgressHUD dismiss];
                
                // 重新cell设置文字
                self.textLabel.text = @"清除缓存(0B)";
            });
        });
    }];
    
}

@end
