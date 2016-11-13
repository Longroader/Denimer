
//
//  LZFAboutUsViewController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/10/11.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFAboutUsViewController.h"

@interface LZFAboutUsViewController ()

@end

@implementation LZFAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *aboutLabel = [[UILabel alloc] init];
    aboutLabel.zf_size = CGSizeMake(210, self.view.zf_height);
    aboutLabel.center = self.view.center;
    aboutLabel.text = @"亲爱的小伙伴\n\n这是个出于兴趣爱好的应用\n\n牛仔裤是我的最爱\n\n希望了解全世界的牛仔品牌\n\n它们有的历史悠久\n\n有的风靡全球\n\n如果你有推荐的品牌\n\n请反馈给我\n\n让Denimer越来越齐全\n\n希望你在此找到喜欢的牛仔\n\n并把它买回家";
    aboutLabel.textColor = [UIColor whiteColor];
    aboutLabel.textAlignment = NSTextAlignmentCenter;
    aboutLabel.numberOfLines = 0;
    aboutLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    aboutLabel.shadowColor = [UIColor lightGrayColor];
//    aboutLabel.shadowOffset = CGSizeMake(5, 5);
    [self.view addSubview:aboutLabel];
}

#pragma mark - 设置状态栏样式
- (BOOL)prefersStatusBarHidden {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
