//
//  LZFTitleButton.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/9/9.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFTitleButton.h"

@implementation LZFTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        self.userInteractionEnabled = YES;
    }
    return self;
}

// 重写setHighlighted方法,并且不调用[super setHighlighted:highlighted],那么所有高亮操作都会失效，用来取消多次点击或长按标题按钮时的闪烁效果
//- (void)setHighlighted:(BOOL)highlighted {}

@end
