//
//  homeTableViewCell.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/3/15.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIImageView *leftImageView;

-(void)initView;

@end
