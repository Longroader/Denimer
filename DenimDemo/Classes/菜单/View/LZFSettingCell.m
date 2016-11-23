//
//  LZFSettingCell.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/11/22.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFSettingCell.h"

@implementation LZFSettingCell

static NSString * const SettingCellID = @"Setting";

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
   
    LZFSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellID];
    if (cell == nil) {
        
        // cell基本外观设置
        cell = [[LZFSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SettingCellID];
        [cell.textLabel setFont:[UIFont systemFontOfSize:15.0]];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.highlighted = YES;
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"检查更新";
        
        // 拿到当前app版本号
        NSString *currVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        
        // 创建版本号label并赋值
        UILabel *currVersionLabel = [[UILabel alloc] init];
        currVersionLabel.zf_x = CGRectGetMaxX(cell.frame);
        currVersionLabel.zf_y = 0;
        currVersionLabel.text = currVersion;
        currVersionLabel.textColor = [UIColor whiteColor];
        [currVersionLabel setFont:[UIFont systemFontOfSize:15.0]];
        [currVersionLabel sizeToFit];
        
        // 将版本号赋值给accessoryView
        cell.accessoryView = currVersionLabel;
    } else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"给我们好评";
    } else if (indexPath.row == 3) {
        
        cell.textLabel.text = @"关于我们";
    }
    
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
