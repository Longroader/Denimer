//
//  LZFMenuViewController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/9/9.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFMenuViewController.h"
#import "LZFClearCacheCell.h"
#import "LZFAboutUsViewController.h"
#import <SVProgressHUD.h>

@interface LZFMenuViewController () <UITableViewDataSource, UITableViewDelegate>

/** 菜单界面tableView */
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end

@implementation LZFMenuViewController

static NSString * const LZFClearCacheCellId = @"LZFClearCacheCell";
static NSString * const menuCellID = @"menuCell";

- (void)viewWillAppear:(BOOL)animated {
    // 界面弹出动画效果
    self.view.zf_height = 0; // 重置height为0
    [UIView animateWithDuration:0.5 animations:^{
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_top_bg_375x667_"]];
        self.view.zf_height = [UIScreen mainScreen].bounds.size.height;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSHomeDirectory();
    [self setupMenuTableView];
}

- (void)setupMenuTableView {
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    
    // 设置tableView行高
    self.menuTableView.rowHeight = 60;
    
    // 注册cell
    [self.menuTableView registerClass:[LZFClearCacheCell class] forCellReuseIdentifier:LZFClearCacheCellId];
}

#pragma mark - 监听
- (IBAction)cancelBtnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) { // 返回自定义清除缓存cell
        
        return [tableView dequeueReusableCellWithIdentifier:LZFClearCacheCellId];
    } else { // 返回其他类型cell
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellID];
        if (cell == nil) {
            // cell基本外观设置
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellID];
            cell.backgroundColor = [UIColor clearColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.highlighted = YES;
        }
        
        if (indexPath.row == 1) {
            cell.textLabel.text = @"检查更新";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"给我们好评";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"关于我们";
        }
        
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { // 点击不同cell时分别进行不同的操作
    
    if (indexPath.row == 1) {
        
        // 展示【检查更新】弹出文本
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已是最新版本哦(⊙o⊙)" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{
            [NSThread sleepForTimeInterval:1.5];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
    } else if (indexPath.row == 2) {
        
        // 展示【给我们评分】弹出文本
        [SVProgressHUD showImage:nil status:@"Thanks☺☺☺"];
        [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, 90)];
        [SVProgressHUD setFadeOutAnimationDuration:1.0];
        [SVProgressHUD setCornerRadius:5];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
        
    } else if (indexPath.row == 3) {
        
        // 展示【关于我们】控制器
        LZFAboutUsViewController *aboutUsVc = [[LZFAboutUsViewController alloc] init];
        aboutUsVc.view.backgroundColor = self.view.backgroundColor;
        aboutUsVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:aboutUsVc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
