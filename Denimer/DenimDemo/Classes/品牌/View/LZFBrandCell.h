//
//  LZFBrandCell.h
//  DenimDemo
//
//  Created by 刘志锋 on 16/10/4.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZFBrand;

@interface LZFBrandCell : UITableViewCell
/** 品牌模型数据 */
@property (nonatomic, strong) LZFBrand *brand;
/** 品牌图片view */
@property (weak, nonatomic) IBOutlet UIImageView *brandImgView;
/** 品牌名字label */
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@end
