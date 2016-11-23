//
//  LZFNewFetureCollectionViewCell.h
//  彩票
//
//  Created by LZF on 14/11/6.
//  Copyright © 2014年 longroader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZFNewFetureCollectionViewCell : UICollectionViewCell
/** 背景图片 */
@property (nonatomic, weak) UIImage *image;

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
@end
