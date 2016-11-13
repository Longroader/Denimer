//
//  LZFDetailViewController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/10/1.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFDetailViewController.h"
#import "LZFWebViewController.h"
#import "LZFBrandCell.h"
#import "LZFBrand.h"
#import <Social/Social.h>
#import <SVProgressHUD.h>

@interface LZFDetailViewController ()

/** Xib中的品牌图片 */
@property (weak, nonatomic) IBOutlet UIImageView *brandImageView;
/** Xib中的品牌简介 */
@property (weak, nonatomic) IBOutlet UILabel *brandDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

- (IBAction)searchButton:(id)sender;
- (IBAction)likeButtonClick:(id)sender;
- (IBAction)shareButtonClick:(id)sender;
@end

@implementation LZFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LZFLogFunc
    
    // 设置品牌图片
    self.brandImageView.image = self.brandImage;
    
    // 设置品牌简介
    self.brandDetailLabel.text = self.brandDetail;
    
    // 设置图片填充模式
//    [self.brandImageView setContentMode:UIViewContentModeScaleAspectFill];
//    self.brandImageView.clipsToBounds = YES;
    
}

- (IBAction)searchButton:(id)sender {
    
    LZFWebViewController *webVc = [[LZFWebViewController alloc] init];
    [self.navigationController pushViewController:webVc animated:YES];
}

- (IBAction)likeButtonClick:(id)sender { 
    // 1.控制按钮选中和取消选中状态
    self.likeBtn.selected = !self.likeBtn.selected;
    if (self.likeBtn.selected) {
        [SVProgressHUD showImage:nil status:@"有品位~"];
        [SVProgressHUD setFadeOutAnimationDuration:1.0];
        [SVProgressHUD setCornerRadius:5];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
    } else {
        [SVProgressHUD showImage:nil status:@"品味变啦~"];
        [SVProgressHUD setFadeOutAnimationDuration:1.0];
        [SVProgressHUD setCornerRadius:5];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
    }
}

- (IBAction)shareButtonClick:(id)sender {
    // 创建活动控制器
    UIAlertController *shareAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [shareAlert addAction:[UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LZFLog(@"点击了微信");
    }]];
    
    [shareAlert addAction:[UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LZFLog(@"点击了朋友圈");
    }]];
    
    [shareAlert addAction:[UIAlertAction actionWithTitle:@"微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LZFLog(@"点击了微博");
        
        // 1.判断平台是否可用
        if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) return;
        
        // 2.1.创建分享控制器
        SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        
        // 2.2.添加默认分享文字和图片
        [composeVc setInitialText:@"找到我喜欢的牛仔了😄。  --From app:酷爱牛仔"];
        [composeVc addImage:[UIImage imageNamed:@"levi's"]];
        
        // 3.弹出分享控制器
        [self presentViewController:composeVc animated:YES completion:nil];
        
        // 4.监听用户点击
        composeVc.completionHandler = ^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultDone) {
                [SVProgressHUD showImage:nil status:@"分享成功~"];
                [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
            } else {
                LZFLog(@"用户点击了取消按钮");
            }
        };
    }]];
    
    [shareAlert addAction:[UIAlertAction actionWithTitle:@"取消分享" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        LZFLog(@"点击了取消");
    }]];
    
    [self presentViewController:shareAlert animated:YES completion:nil ];
}
@end
