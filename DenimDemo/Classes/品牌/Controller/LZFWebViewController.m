//
//  LZFWebViewController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/10/8.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFWebViewController.h"

@interface LZFWebViewController ()

@end

@implementation LZFWebViewController

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
    NSURL *url = [NSURL URLWithString:@"https://m.baidu.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [baiduView loadRequest:request];
    
    [self.view addSubview:baiduView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
