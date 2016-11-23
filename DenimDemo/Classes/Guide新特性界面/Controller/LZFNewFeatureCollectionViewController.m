//
//  LZFNewFeatureCollectionViewController.m
//  彩票
//
//  Created by LZF on 14/11/6.
//  Copyright © 2014年 longroader. All rights reserved.
//

#import "LZFNewFeatureCollectionViewController.h"
#import "LZFNewFetureCollectionViewCell.h"

@interface LZFNewFeatureCollectionViewController ()

/** 记录上一次偏移量 */
@property (nonatomic, assign) CGFloat lastOffsetX;
/** 中间图片 */
@property (nonatomic, weak) UIImageView *guide;
/** 大标题 */
@property (nonatomic, weak) UIImageView *guideLargeText;
/** 小标题 */
@property (nonatomic, weak) UIImageView *guideSmallText;

@end

@implementation LZFNewFeatureCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#define LZFPage 4

// 重写init方法，这样外界创建
- (instancetype)init {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 修改item大小
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    // 修改item行间距
    flowLayout.minimumLineSpacing = 0;
    // 修改每个item间距
    flowLayout.minimumInteritemSpacing = 0;
    // 修改滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 修改每一组的内边距
//    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupCollectionView];
    
    [self addChildImageView];
    
}

#pragma mark - 基本设置
- (void)setupCollectionView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = LZFRandomColor;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //    调整collectionview尺寸
    //    self.collectionView.zf_size = CGSizeMake(200, 300);
    //    self.collectionView.center = self.view.center;
    
    // 注册cell
    [self.collectionView registerClass:[LZFNewFetureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - 基本设置
- (void)addChildImageView {
    
    // 线
    UIImageView *guideLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    [self.collectionView addSubview:guideLine];
    guideLine.zf_x -= 150;
    
    // 球
    UIImageView *guide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    [self.collectionView addSubview:guide];
    guide.zf_x += 50;
    self.guide = guide;
    
    // 大标题
    UIImageView *guideLargeText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    [self.collectionView addSubview:guideLargeText];
    guideLargeText.center = CGPointMake(self.view.zf_width / 2, self.view.zf_height * 0.7f);
    self.guideLargeText = guideLargeText;
    
    // 小标题
    UIImageView *guideSmallText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    [self.collectionView addSubview:guideSmallText];
    
    guideSmallText.center = CGPointMake(self.view.zf_width / 2, self.view.zf_height * 0.8f);
    self.guideSmallText = guideSmallText;
    
}

#pragma mark <UIScrollViewDelegate> 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 做动画思路：平移一个屏幕宽度
    // 计算scrollView当前总偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 计算页码
    NSUInteger pageIndex = offsetX / scrollView.zf_width + 1;
    
    // 切换图片
    NSString *name = [NSString stringWithFormat:@"guide%ld", (unsigned long)pageIndex];
    self.guide.image = [UIImage imageNamed:name];
    
    NSString *largeTextName = [NSString stringWithFormat:@"guideLargeText%ld", (unsigned long)pageIndex];
    UIImage *largeTextImage = [UIImage imageNamed:largeTextName];
    self.guideLargeText.image = largeTextImage;
    
    NSString *guideSmallText = [NSString stringWithFormat:@"guideSmallText%ld", (unsigned long)pageIndex];
    self.guideSmallText.image = [UIImage imageNamed:guideSmallText];
    
    // 计算scrollView单次滑动偏移量
    CGFloat oneOffsetX = offsetX - self.lastOffsetX;
    
    // 动画显示切换后的图片
    self.guide.zf_x += oneOffsetX * 2; // 先让图片右移两个屏幕宽度
    self.guideLargeText.zf_x += oneOffsetX * 2;
    self.guideSmallText.zf_x += oneOffsetX * 2;
    
    [UIView animateWithDuration:0.25 animations:^{ // 再让图片左移一个屏幕宽度显示出来
        self.guide.zf_x -= oneOffsetX;
        self.guideLargeText.zf_x -= oneOffsetX;
        self.guideSmallText.zf_x -= oneOffsetX;
    }];
    
    // 记录上一次滑动偏移量
    self.lastOffsetX = offsetX;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LZFNewFetureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = LZFRandomColor;
    
    // 设置背景图片
    NSString *name = [NSString stringWithFormat:@"guide%ldBackground568h", indexPath.item + 1];
    UIImage *image = [UIImage imageNamed:name];
    cell.image = image;
    
    // 当滑动到最后一个cell时，显示立即体验按钮
    [cell setIndexPath:indexPath count:LZFPage];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
