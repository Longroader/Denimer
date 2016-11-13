//
//  LZFChannelCell.m
//  Love Denim
//
//  Created by 刘志锋 on 16/9/3.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFChannelCell.h"

@interface LZFChannelCell()
@end

@implementation LZFChannelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    _channelImageView.image = image;
}

- (void)setChannelName:(NSString *)channelName {
    
    _channelName = channelName;
    
    _channelNameLabel.text = channelName;
}

@end
