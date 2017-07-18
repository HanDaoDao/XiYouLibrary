//
//  settingTableViewCell.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/12.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "settingTableViewCell.h"

@implementation settingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)initSettingCell{
    _label = [[UILabel alloc] init];
    [self.contentView addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.contentView.mas_height);
    }];
    
    _rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_rightImageView];
    
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.05);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.6);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
