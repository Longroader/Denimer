//
//  LZFChannelViewController.m
//  Love Denim
//
//  Created by 刘志锋 on 16/9/3.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFChannelViewController.h"
#import "LZFBrandViewController.h"
#import "LZFChannelCell.h"
#import "LZFTaobaoWebViewController.h"

@interface LZFChannelViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation LZFChannelViewController

static NSString * const channelID = @"channelCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
}

# pragma mark - 初始化
- (void)setupCollectionView {
    // 创建频道collecView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(LZFmainScreamWidth * 0.5 - 10, LZFmainScreamWidth * 0.5 - 10);
//    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 10;
    
    UICollectionView *channelColleView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    channelColleView.showsVerticalScrollIndicator = NO;
//    channelColleView.backgroundColor = [UIColor grayColor];
    channelColleView.contentInset = UIEdgeInsetsMake(69, 5, 5, 5);
    
    [self.view addSubview:channelColleView];
    
    // 设置数据源
    channelColleView.dataSource = self;
    channelColleView.delegate = self;
    // 注册cell
    [channelColleView registerNib:[UINib nibWithNibName:NSStringFromClass([LZFChannelCell class]) bundle:nil] forCellWithReuseIdentifier:channelID];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LZFChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:channelID forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    
    NSArray *channelNames = @[@"#水洗#", @"#原牛#", @"#蓝染#", @"#嘻哈#", @"#复古#", @"#破洞#", @"#粗犷#", @"#日牛#", @"#意大利#", @"#美牛#"];
    
    cell.channelNameLabel.text = [NSString stringWithFormat:@"%@", channelNames[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *sweetAlert = [UIAlertController alertControllerWithTitle:@"亲爱的用户" message:@"Oops!! 这是丹宁库的第一个版本，分类搜索功能正在完善中，看到了喜欢的吗，去淘宝逛逛?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"先不去" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *openTaobaoAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 点击后跳转
        [self openTaobao];
    }];
    
    [sweetAlert addAction:cancelAction];
    [sweetAlert addAction:openTaobaoAction];
    
    [self presentViewController:sweetAlert animated:YES completion:nil];
}

#pragma mark - 跳转到淘宝或天猫客户端
- (void)openTaobao {
    
    NSURL *taobaoUrl = [NSURL URLWithString:@"taobao://"];
    
    NSURL *tmallUrl = [NSURL URLWithString:@"tmall://"];
    
    if ([[UIApplication sharedApplication] canOpenURL:taobaoUrl]) {
        
        //能打开淘宝就打开淘宝
        [[UIApplication sharedApplication] openURL:taobaoUrl];
        
    } else if ([[UIApplication sharedApplication] canOpenURL:tmallUrl]) {
        
        //能打开天猫就打开天猫
        [[UIApplication sharedApplication] openURL:tmallUrl];
        
    } else {
        
        //都打不开就自己加载网页
        LZFTaobaoWebViewController *taobaoWebVc = [[LZFTaobaoWebViewController alloc] init];
        [self.navigationController pushViewController:taobaoWebVc animated:YES];
    }
}

@end
