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
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initView];
    }
    return self;
}
-(void)initView{
    
    UIImage *img = [UIImage imageNamed:@"circle"];
    _leftImageView = [[UIImageView alloc] initWithImage:img];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_leftImageView];
    
    _label = [[UILabel alloc] init];
    //设置label字体及字体大小
    _label.font = [UIFont fontWithName:@"Gill Sans" size:17];
    //设置自动换行
    _label.numberOfLines = 0;//表示可以换多行
    _label.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_label];
    
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.06);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.2);
    }];
//    
//    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.leftImageView.mas_right);
//        make.right.equalTo(self.contentView.mas_right);
//        make.height.equalTo(self.contentView.mas_height);
//    }];
    
}



@end
