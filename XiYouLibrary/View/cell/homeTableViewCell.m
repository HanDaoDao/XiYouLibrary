//
//  homeTableViewCell.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/3/15.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "homeTableViewCell.h"
#import "Masonry.h"

@implementation homeTableViewCell

-(void)initView{
    
    UIImage *img = [UIImage imageNamed:@"circle"];
    _leftImageView = [[UIImageView alloc] initWithImage:img];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_leftImageView];
    
    _label = [[UILabel alloc] init];
    //设置label字体及字体大小
    _label.font = [UIFont fontWithName:@"Gill Sans" size:17];
    //设置自动换行
    _label.numberOfLines = 0;
    //表示可以换多行
    _label.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_label];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.backgroundColor = [UIColor yellowColor];
    _timeLabel.font = [UIFont fontWithName:@"Gill Sans" size:15];
    _timeLabel.text = @"aaaaaaa";
//    [self addSubview:_timeLabel];
    
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.equalTo(self.mas_width).multipliedBy(0.06);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.leftImageView.mas_right);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self.mas_height);
//        make.bottom.equalTo(_timeLabel.mas_top);
    }];
    

}


@end
