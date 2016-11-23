//
//  LZFBrandViewController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/9/9.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFBrandViewController.h"
#import "LZFDetailViewController.h"
#import "LZFTitleButton.h"
#import "LZFBrandCell.h"
#import "LZFBrand.h"

@interface LZFBrandViewController ()

/** 假数据量 */
@property (nonatomic, assign) NSInteger dataCount;
/** 品牌数组 */
@property (nonatomic, copy) NSArray *brandArray;

/** 下拉刷新控件 */
@property (nonatomic, weak) UIView *header;
/** 下拉刷新控件文字 */
@property (nonatomic, weak) UILabel *headerLabel;
/** 下拉刷新控件是否正在刷新 */
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;
/** 上拉刷新控件 */
@property (nonatomic, weak) UIView *footer;
/** 上拉刷新控件文字 */
@property (nonatomic, weak) UILabel *footerLabel;
/** 上拉刷新控件是否正在刷新 */
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@end

@implementation LZFBrandViewController

static NSString *LZFBrandCellID = @"brand";

#pragma mark - 懒加载
- (NSArray *)brandArray {
    
    if (!_brandArray) {
#warning plist:创建plist文件并写入数据
        /*
        self.brandArray = @[
                            @{@"name":@"7ForAllMankind", @"icon":@"7 for all mainkind"},
                            @{@"name":@"45rpm", @"icon":@"45rpm"},
                            @{@"name":@"CK Jeans", @"icon":@"CK Jeans"},
                            @{@"name":@"LEE", @"icon":@"lee"},
                            @{@"name":@"levi's包", @"icon":@"levi's"},
                            @{@"name":@"wrangler", @"icon":@"wrangler"}
                            ];
        
        [_brandArray writeToFile:@"/Users/liuzhifeng/Desktop/brand.plist" atomically:YES];
        */// 1.创建品牌数组
        NSString *path = [[NSBundle mainBundle] pathForResource:@"brand.plist" ofType:nil]; // 1.1.获取plist文件路径
        self.brandArray = [NSArray arrayWithContentsOfFile:path]; // 1.2.创建品牌数组
        
        // 2.字典转模型 -> 本质:字典数组转成模型数组
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in self.brandArray) { // 2.1.取出字典
            LZFBrand *brand = [[LZFBrand alloc] init]; // 2.2.创建模型(LZFBrand对象)，用字典赋值
            brand.name = dict[@"name"];
            brand.icon = dict[@"icon"];
            brand.detail = dict[@"detail"];
            [tempArr addObject:brand]; // 2.3.将赋值后的模型存入临时数组
        }
        self.brandArray = tempArr; // 2.4.将数组重新赋值
    }
    return _brandArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LZFLogFunc
    
    self.dataCount = self.brandArray.count;
    
    // 基本设置
    [self setupTable];
    
    // 设置tableFooterView
    [self setupRefresh];
    
    // 添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:LZFTitleButtonDidRepeatClickNotification object:nil];
}

#pragma mark - dealloc方法
- (void)dealloc {
    // 移除通知观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 基本设置
- (void)setupTable {
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);// 穿透效果
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.rowHeight = 200;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZFBrandCell class]) bundle:nil] forCellReuseIdentifier:LZFBrandCellID];
}

#pragma mark - 设置刷新控件
- (void)setupRefresh {
    /*
    UILabel *adLabel = [[UILabel alloc] init];
    adLabel.frame = CGRectMake(0, 0, self.tableView.zf_width, 40);
    adLabel.text = @"广告:在这里找到你感兴趣的Denim";
    adLabel.textColor = [UIColor whiteColor];
    [adLabel setFont:[UIFont systemFontOfSize:14]];
    adLabel.backgroundColor = [UIColor lightGrayColor];
    adLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:adLabel];
    self.tableView.tableHeaderView = adLabel;
     */ // 广告
    
    // header
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, -35, self.tableView.zf_width, 35);
    [self.tableView addSubview:header];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = header.bounds;
    headerLabel.text = @"下拉刷新";
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setFont:[UIFont systemFontOfSize:12]];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:headerLabel];
    self.header = header;
    self.headerLabel = headerLabel;
    
    // 默认让header自动进行一次刷新
     [self headerBeginRefreshing];
    
    // footer
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(LZFSmallMargin, 0, self.tableView.zf_width - LZFMargin, 35);
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = footer.bounds;
    footerLabel.backgroundColor = [UIColor whiteColor];
    footerLabel.text = @"上拉加载更多";
    [footerLabel setTextColor:[UIColor blackColor]];
    [footerLabel setFont:[UIFont systemFontOfSize:12]];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLabel];
    self.footer = footer;
    self.footerLabel = footerLabel;
    self.tableView.tableFooterView = footer;
}

- (void)dealHeader {
    
    // 如果正在下拉刷新，直接返回
    if (self.isHeaderRefreshing) return;
    
    CGFloat offsetY = -(self.tableView.contentInset.top + self.header.zf_height);
    if (self.tableView.contentOffset.y <= offsetY) { // header完全出现
        self.headerLabel.text = @"松开刷新";
    } else {
        self.headerLabel.text = @"下拉刷新";
    }
}

- (void)dealFooter {
    
    // tableView无内容时，直接返回
    if (self.tableView.contentSize.height == 0) return;
    
    // 当tableView偏移量大于offSetY时,代表footer已经完全出现,进入刷新状态
    CGFloat offSetY = self.tableView.contentSize.height - self.tableView.zf_height;
    if (self.tableView.contentOffset.y >= offSetY && self.tableView.contentOffset.y > -(self.tableView.contentInset.top)) { // footer完全出现,并且是往上拖拽时
        
        // 进入上拉刷新
        [self footerBeginRefreshing];
    }
}

#pragma mark - 事件监听
/** 监听titleButton重复点击 */
- (void)titleButtonRepeatClick {
    
    if (self.view.window == nil) return; // 这个属性非常重要
    if (self.tableView.scrollsToTop == NO) return;
    
    // 开始下拉刷新
//    [self headerBeginRefreshing];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.footer.hidden = (self.brandArray.count == 0); // 当品牌数组元素为0时，隐藏footer;
    return self.brandArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZFBrandCell *brandCell = [tableView dequeueReusableCellWithIdentifier:LZFBrandCellID];
    // 设置数据
    brandCell.brand = self.brandArray[indexPath.row];
    
    return brandCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZFLog(@"选中cell--%ld", indexPath.row);
    LZFBrandCell *brandCell = [tableView dequeueReusableCellWithIdentifier:LZFBrandCellID];
    brandCell.brand = self.brandArray[indexPath.row];

    LZFDetailViewController *detailVc = [[LZFDetailViewController alloc] init];
    detailVc.navigationItem.title = brandCell.brand.name; // 设置品牌详情页导航栏标题
    detailVc.brandImage = [UIImage imageNamed:brandCell.brand.icon]; // 设置品牌详情页的品牌图片
    detailVc.brandDetail = [NSString stringWithFormat:@"%@", brandCell.brand.detail]; // 设置品牌介绍内容
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    // 动态隐藏和显示导航条
    if(velocity.y > 0) { // 加速度 > 0 时隐藏导航条
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

/** 监听 header 完全出现的情况: 这里决定何时开始刷新数据 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    CGFloat offsetY = -(self.tableView.contentInset.top + self.header.zf_height);
    if (self.tableView.contentOffset.y <= offsetY) { // header完全出现
        
        [self headerBeginRefreshing];
    }
}

/** 监听 header 和 footer 完全出现的情况: 这里决定何时开始请求更多数据 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 1.处理header
    [self dealHeader];
    
    // 2.处理footer
    [self dealFooter];
}

#pragma mark - 刷新业务处理
- (void)headerBeginRefreshing {
    
    // 如果正在下拉刷新，直接返回
    if (self.isHeaderRefreshing) return;
    
    // 1.进入下拉刷新
    self.headerLabel.text = @"正在刷新";
    self.headerRefreshing = YES;
    
    // 2.增加tableView内边距
    [UIView animateWithDuration:0.25 animations:^{
        // 2.1.顶部增加一个header的高度
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.zf_height;
        self.tableView.contentInset = inset;
        
        // 2.2.修改tableView偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
    }];
    
    // 3.发送网络请求
    [self loadNewData];
}

- (void)headerEndRefreshing {
    
    self.headerRefreshing = NO;
    // 5.减少tableView内边距
    [UIView animateWithDuration:0.5 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.zf_height;
        self.tableView.contentInset = inset;
    }];
}

- (void)footerBeginRefreshing {
    
    // 如果正在上拉刷新，直接返回
    if (self.isFooterRefreshing) return;
    
    // 进入上拉刷新
    self.footerRefreshing = YES;
    self.footerLabel.text = @"正在加载";
    [self.footerLabel setTextColor:[UIColor darkGrayColor]];
    self.footerLabel.backgroundColor = [UIColor lightGrayColor];
    
    // 发送网络请求:加载更多数据
    [self loadMoreData];
}

- (void)footerEndRefreshing {
    
    self.footerRefreshing = NO;
    self.footerLabel.backgroundColor = [UIColor whiteColor];
    self.footerLabel.text = @"上拉加载更多";
    [self.footerLabel setTextColor:[UIColor blackColor]];
    [self.footerLabel setFont:[UIFont systemFontOfSize:12]];
}

#pragma mark - 网络数据处理
- (void)loadNewData {
    
    // 异步请求数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 模拟服务器返回了最新数据
        LZFLog(@"服务器返回了数据");
        self.dataCount = 6;
        [self.tableView reloadData];
        
        // 4.结束下拉刷新
        [self headerEndRefreshing];
    });
}

- (void)loadMoreData {
    // 异步请求数据
    LZFLog(@"发送网络请求，加载更多数据");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 模拟服务器返回了更多数据
        self.dataCount = self.brandArray.count;
        [self.tableView reloadData];
        
        // 结束上拉刷新
        [self footerEndRefreshing];
    });
}

@end
