//
//  mineTableViewCell.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/7.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "mineTableViewCell.h"

@implementation mineTableViewCell

-(void)initMineInformationCell{
    
    _headImageView = [[UIImageView alloc] init];
    _headImageView.image = [UIImage imageNamed:@"头像"];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 60/2.0f;
    [self.contentView addSubview:_headImageView];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.and.height.mas_equalTo(60);
    }];
    
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:@"Gill Sans" size:22];
//    _nameLabel.text = @"小茗同学";
    [self.contentView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(_headImageView.mas_right).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    _majorLabel = [[UILabel alloc] init];
    _majorLabel.font = [UIFont systemFontOfSize:16];
    _majorLabel.text = @"软件1404";
    [self.contentView addSubview:_majorLabel];
    
    [_majorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.equalTo(_headImageView.mas_right).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    _IDLabel = [[UILabel alloc] init];
    _IDLabel.font = [UIFont systemFontOfSize:16];
    _IDLabel.text = @"04143137";
    [self.contentView addSubview:_IDLabel];
    
    [_IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.equalTo(_majorLabel.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];

}

-(void)initMineCell{
    _cellLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_cellLabel];
    
    [_cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.7);
        make.height.equalTo(self.contentView.mas_height);
    }];
    
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.image = [UIImage imageNamed:@"更多"];
    [self.contentView addSubview:_rightImageView];
    
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.05);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.6);
    }];

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















