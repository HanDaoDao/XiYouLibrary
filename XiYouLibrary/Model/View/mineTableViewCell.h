//
//  mineTableViewCell.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/7.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface mineTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *majorLabel;
@property(nonatomic,strong) UILabel *IDLabel;
@property(nonatomic,strong) UILabel *cellLabel;
@property(nonatomic,strong) UIImageView *rightImageView;

-(void)initMineInformationCell;
-(void)initMineCell;

@end
