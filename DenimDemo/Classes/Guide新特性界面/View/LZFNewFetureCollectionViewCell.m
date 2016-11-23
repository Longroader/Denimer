//
//  LZFNewFetureCollectionViewCell.m
//  彩票
//
//  Created by LZF on 14/11/6.
//  Copyright © 2014年 longroader. All rights reserved.
//

#import "LZFNewFetureCollectionViewCell.h"
#import "LZFHomeViewController.h"

@interface LZFNewFetureCollectionViewCell()

/** 背景图片 */
@property (nonatomic, weak) UIImageView *bgImageView;
/** 立即体验按钮 */
@property (nonatomic, weak) UIButton *startBtn;

@end

@implementation LZFNewFetureCollectionViewCell

#pragma mark - 懒加载
- (UIImageView *)bgImageView {
    
    if (!_bgImageView) {
        UIImageView *BgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:BgImageView];
        _bgImageView = BgImageView;
    }
    return _bgImageView;
}

- (UIButton *)startBtn {
    if (!_startBtn) {
        
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        [startBtn sizeToFit];
        startBtn.center = CGPointMake(self.zf_width / 2, self.zf_height * 0.9f);
        [self.contentView addSubview:startBtn];
        [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
        _startBtn = startBtn;
    }
    return _startBtn;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.bgImageView.image = image;
}

- (void)startClick {
    
    // 切换到应用主界面
    LZFHomeViewController *HomeVc = [[LZFHomeViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = HomeVc;
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count {
    
//     当滑动到最后一个collectionCell时
        if (indexPath.item == count - 1) {
            // 最后一页时显示立即体验按钮
            self.startBtn.hidden = NO;
        } else {
            // 隐藏立即体验按钮
            self.startBtn.hidden = YES;
        }
}

@end
