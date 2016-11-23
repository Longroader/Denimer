//
//  LZFTaobaoWebViewController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/11/22.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFTaobaoWebViewController.h"

@interface LZFTaobaoWebViewController ()

@end

@implementation LZFTaobaoWebViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 进入网页时隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 退出网页时显示导航条
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LZFLogFunc
    
    // 百度一下
    UIWebView *baiduView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:@"https://m.taobao.com/#index"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [baiduView loadRequest:request];
    
    [self.view addSubview:baiduView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
