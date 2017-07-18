//
//  homeTableViewCell.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/6/5.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeTableViewCell : UIView

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIImageView *leftImageView;
@property(nonatomic,strong) UILabel *timeLabel;

-(void)initView;

@end
