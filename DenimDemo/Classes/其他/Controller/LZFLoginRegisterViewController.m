//
//  LZFLoginRegisterViewController.m
//  百思不得姐练习
//
//  Created by 刘志锋 on 16/6/5.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFLoginRegisterViewController.h"

@interface LZFLoginRegisterViewController ()

//@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation LZFLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //用代码设置登录按钮的圆角，也可以用xib里的KVC来办到
//    self.loginButton.layer.cornerRadius = 5;
//    self.loginButton.layer.masksToBounds = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  显示登陆、注册界面
 */
- (IBAction)showLoginOrRegister:(UIButton *)button {
    // 退出键盘
    [self.view endEditing:YES];
    
    // 设置约束和按钮状态
    if (self.leftMargin.constant) {
        self.leftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    } else{
        self.leftMargin.constant = - self.view.zf_width;
        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
    }
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
