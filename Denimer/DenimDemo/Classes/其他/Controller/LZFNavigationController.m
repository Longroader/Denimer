//
//  LZFNavigationController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/9/8.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFNavigationController.h"
#import "LZFWebViewController.h"
@interface LZFNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation LZFNavigationController

#pragma mark - 全屏右滑返回
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.设置导航条风格
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    
    // 2.创建全屏滑动手势识别器
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    // 添加手势识别器
    [self.view addGestureRecognizer:pan];
    // 设置手势识别器的代理:为了控制手势什么时候触发
    pan.delegate = self;
    // 禁用系统手势识别器
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

#pragma mark - 自定义导航条返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"nav_backicon"] forState:UIControlStateNormal];
//    [btn setTitle:@"返回" forState: UIControlStateNormal];
//    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    // 将UIbutton包装成UIBarButtonItem
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    viewController.navigationItem.leftBarButtonItem = backBtn;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 导航条返回按钮点击
- (void)backBtnClick {
    
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
