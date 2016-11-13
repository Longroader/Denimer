//
//  LZFChannelCell.h
//  Love Denim
//
//  Created by 刘志锋 on 16/9/3.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZFChannelCell : UICollectionViewCell
/** channelImage */
@property (nonatomic, strong) UIImage *image;
/** channelName */
@property (nonatomic, strong) NSString *channelName;

@property (weak, nonatomic) IBOutlet UIImageView *channelImageView;

@property (weak, nonatomic) IBOutlet UILabel *channelNameLabel;

@end
