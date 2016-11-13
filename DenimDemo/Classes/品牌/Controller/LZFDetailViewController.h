//
//  LZFDetailViewController.h
//  DenimDemo
//
//  Created by 刘志锋 on 16/10/1.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZFDetailViewController : UIViewController

#warning 接收LZFBrandViewController的cellForRow方法中赋值过来的图片和文本，再赋值给.m中的私有成员变量，暂时只会用这种方法，以后再改。
/** 品牌图片 */
@property (nonatomic, strong) UIImage *brandImage;
/** 品牌简介 */
@property (nonatomic, strong) NSString *brandDetail;
@end
