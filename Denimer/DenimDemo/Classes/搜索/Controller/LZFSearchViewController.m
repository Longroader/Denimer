//
//  LZFSearchViewController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/10/10.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFSearchViewController.h"

@interface LZFSearchViewController ()

@end

@implementation LZFSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 进入时隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 退出时显示导航条
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)cancelBtnClick {
    // 剑姬取消搜索按钮返回主页
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
