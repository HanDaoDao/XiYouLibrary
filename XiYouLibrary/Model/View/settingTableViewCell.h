//
//  settingTableViewCell.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/12.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface settingTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIImageView *rightImageView;

-(void)initSettingCell;

@end
