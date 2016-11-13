//
//  LZFChannelViewController.m
//  Love Denim
//
//  Created by 刘志锋 on 16/9/3.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFChannelViewController.h"
#import "LZFChannelCell.h"

@interface LZFChannelViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation LZFChannelViewController

static NSString * const channelID = @"channelCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    LZFLogFunc
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupCollectionView];
    
}

# pragma mark - 初始化
- (void)setupCollectionView {
    // 创建频道collecView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(LZFmainScreamWidth * 0.5, LZFmainScreamWidth * 0.5);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    UICollectionView *channelColleView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    channelColleView.showsVerticalScrollIndicator = NO;
    channelColleView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
    
    [self.view addSubview:channelColleView];
    
    // 设置数据源
    channelColleView.dataSource = self;
    channelColleView.delegate = self;
    // 注册cell
    [channelColleView registerNib:[UINib nibWithNibName:NSStringFromClass([LZFChannelCell class]) bundle:nil] forCellWithReuseIdentifier:channelID];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LZFChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:channelID forIndexPath:indexPath];
    
    cell.backgroundColor = LZFRandomColor;
    NSString *imageName = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    
    NSArray *channelNames = @[@"#水洗#", @"#原牛#", @"#时尚#", @"#粗犷#", @"#手工#", @"#蓝染#", @"#水洗#", @"#复古#", @"#破洞#", @"#日牛#", @"#意大利#", @"#街头#"];
    
    cell.channelNameLabel.text = [NSString stringWithFormat:@"%@", channelNames[indexPath.row]];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = cell.frame;
//    btn.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
//    [cell addSubview:btn];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LZFLogFunc

}

@end
