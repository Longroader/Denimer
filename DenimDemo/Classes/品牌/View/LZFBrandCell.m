//
//  LZFBrandCell.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/10/4.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFBrandCell.h"
#import "LZFBrand.h"

@interface LZFBrandCell ()

@end

@implementation LZFBrandCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = LZFGlobleBgColor;
    
    // 取消cell被选中和点击高亮效果,方式一
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.highlighted = NO;
}

// 取消cell被选中和点击高亮效果，方式二
/*
 //-(void)setSelected:(BOOL)selected animated:(BOOL)animated {}
 //-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {}
 */

/** 设置cell数据 */
- (void)setBrand:(LZFBrand *)brand {
    
    _brand = brand;
    self.brandImgView.image = [UIImage imageNamed:brand.icon];
    self.brandNameLabel.text = brand.name;
}

/** 重写这个方法的目的：能够拦截所有设置cell的操作 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= LZFSmallMargin;
//    frame.origin.y += LZFMargin;
    frame.origin.x += LZFSmallMargin;
    frame.size.width -= 2 * LZFSmallMargin;
    
    [super setFrame:frame];
}

//+ (instancetype)lzf_viewFromXib {
//    
//    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
//}

@end
