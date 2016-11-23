//
//  LZFHomeViewController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/9/8.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFHomeViewController.h"
#import "UIView+ZFExtension.h"
#import "LZFTitleButton.h"
#import "LZFMenuViewController.h"
#import "LZFSearchViewController.h"
#import "LZFBrandViewController.h"
#import "LZFChannelViewController.h"

@interface LZFHomeViewController () <UIScrollViewDelegate>
/** 被选中的标题按钮 */
@property (nonatomic, weak) LZFTitleButton *selectedTitleButton;
/** 标题按钮底部指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 标题栏整体 */
@property (nonatomic, weak) UIView *titlesview;
/** 主页scrollView */
@property (nonatomic, weak) UIScrollView *homeScrollView;
@end

@implementation LZFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 设置导航条透明
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self setupNav]; // 设置导航栏图标
    
    [self setupTitlesView]; // 设置子控制器标题
    
    [self setupChildVcs]; // 设置子控制器
    
    [self setupHomeScrollView]; // 设置容纳子控制器view的滚动视图
    
    [self addChildVcView]; // 添加子控制器的view
    
}

#pragma mark - 初始化
- (void)setupNav {
    
    // 设置导航栏左右按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(navMenuClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_icon_search_16x16_"] style:UIBarButtonItemStylePlain target:self action:@selector(navSearchClick)];
}

- (void)setupChildVcs {
    
    LZFBrandViewController *brandVc = [[LZFBrandViewController alloc] init];
    [self addChildViewController:brandVc];
    
    LZFChannelViewController *channelVc = [[LZFChannelViewController alloc] init];
    [self addChildViewController:channelVc];
}

- (void)setupTitlesView {
    // 1.创建标题view
    UIView *titlesview = [[UIView alloc] init];
    titlesview.zf_y = self.navigationController.navigationBar.zf_y;
    CGFloat titlesviewH = self.navigationController.navigationBar.zf_height;
    titlesview.zf_size = CGSizeMake(self.view.zf_width / 2, titlesviewH);
    titlesview.zf_centerX = self.navigationController.navigationBar.zf_centerX;
    self.navigationItem.titleView = titlesview;
    self.titlesview = titlesview;
    // 2.创建标题按钮
    NSArray *titles = @[@"品牌", @"分类"];
    
    CGFloat titleButtonW = titlesview.zf_width / 2;
    CGFloat titleButtonH = titlesview.zf_height;
    
    for (NSUInteger i = 0; i < titles.count; i++) {
        LZFTitleButton *titleButton = [LZFTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        titleButton.frame = CGRectMake(titleButtonW * i, 0, titleButtonW, titleButtonH);
        [titlesview addSubview:titleButton];
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 3.创建标题底部指示器
    LZFTitleButton *firstTitleButton = titlesview.subviews.firstObject;
    UIView *indicatorView = [[UIView alloc] init];
    self.indicatorView = indicatorView;
    indicatorView.zf_height = 2;
    indicatorView.zf_y = titlesview.zf_height - indicatorView.zf_height;
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [titlesview addSubview:indicatorView];
    
    // 立刻根据标题文字宽度计算出指示器的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.zf_width = firstTitleButton.titleLabel.zf_width;
    indicatorView.zf_centerX = firstTitleButton.zf_centerX;
    
    [self titleClick:firstTitleButton];
}

- (void)setupHomeScrollView {
    // 取消自动调整scrollView内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *homeScrollView = [[UIScrollView alloc] init];
    NSUInteger count = self.childViewControllers.count;
    homeScrollView.frame = self.view.bounds;
    homeScrollView.contentSize = CGSizeMake(homeScrollView.zf_width * count, 0);
    
    homeScrollView.showsVerticalScrollIndicator = YES;
    homeScrollView.showsHorizontalScrollIndicator = NO;
    homeScrollView.pagingEnabled = YES;
    homeScrollView.bounces = NO;
    homeScrollView.scrollsToTop = NO;
    
    homeScrollView.delegate = self;
    
    [self.view addSubview:homeScrollView];
    self.homeScrollView = homeScrollView;
    
    // 添加子控制器的view
    for (NSUInteger i = 0; i < count; i++) {
        UIView *childVc = self.childViewControllers[i].view;
        childVc.frame = CGRectMake(i * homeScrollView.zf_width, 0, homeScrollView.zf_width, homeScrollView.zf_height);
        [self.homeScrollView addSubview:childVc];
    }
}

#pragma mark - 监听点击
- (void)titleClick:(LZFTitleButton *)titleButton {
#warning repeatClick:标题按钮重复点击通知
    if (self.selectedTitleButton == titleButton) { // 如果标题按钮被重复点击了
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LZFTitleButtonDidRepeatClickNotification object:nil];
    }
    
    // 控制按钮选中和取消选中状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 让底部指示器滚动到被点击的标题
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.zf_width = titleButton.zf_width / 2;
        self.indicatorView.zf_centerX = self.selectedTitleButton.zf_centerX;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.indicatorView.zf_width = titleButton.titleLabel.zf_width;
            self.indicatorView.zf_centerX = self.selectedTitleButton.zf_centerX;
        }];
    }];
    
    // 让homeScrollview滚动到被点击的标题对应的view
    CGPoint offset = self.homeScrollView.contentOffset;
    offset.x = self.homeScrollView.zf_width * titleButton.tag;
    [self.homeScrollView setContentOffset:offset animated:YES];
    
    // 让被点击标题对应的子控制器响应状态栏点击滚动到最顶部
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建,就不用处理，这句必须写，要不然还未使用的子控制器都会因为遍历被加载
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == titleButton.tag);
    }
}

- (void)navMenuClick {
    
    NSLog(@"%s", __func__);
    LZFMenuViewController *menuVc = [[LZFMenuViewController alloc] init];
    menuVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:menuVc animated:YES completion:nil];
}

- (void)navSearchClick {
    
    // 创建搜索控制器并显示出来
    LZFSearchViewController *searchVc = [[LZFSearchViewController alloc] init];
    
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark - 懒加载子控制器的View
- (void)addChildVcView {
    
    // 计算子控制器的索引
    NSUInteger index = self.homeScrollView.contentOffset.x / self.homeScrollView.zf_width;
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    // 懒加载
    if ([childVc isViewLoaded]) return;
    
    childVc.view.frame = self.homeScrollView.bounds;
    [self.homeScrollView addSubview:childVc.view];
}

#pragma mark - UIScrollViewDelegate
/** 调用setContentOffset或scrollRectVisible:animated:其中一个方法使scrollview滚动完毕后,会调用这个方法 */
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    
//    [self addChildVcView];
//}

/** 用户拖拽scrollview产生的滚动会调用这个方法 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.zf_width;
    LZFTitleButton *titleButton = self.titlesview.subviews[index];
    [self titleClick:titleButton];
    
//    [self addChildVcView];
}

#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
