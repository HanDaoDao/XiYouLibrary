//
//  MineCell.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/13.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Masonry.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MineCell : UIView

//title为公用的label
@property (strong, nonatomic) UILabel *titleLabel;          //书名
//我的借阅label
@property (strong, nonatomic) UILabel *departmentLabel;     //所在分馆
@property (strong, nonatomic) UILabel *stateLabel;          //当前状态
@property (strong, nonatomic) UIButton *stateButton;        //当前状态
@property (strong, nonatomic) UILabel *dateLabel;           //应还日期
//我的收藏
@property (strong, nonatomic) UILabel *pubLabel;            //出版社
@property (strong, nonatomic) UILabel *sortLabel;           //索书号
@property (strong, nonatomic) UILabel *authorLabel;         //作者
@property (strong, nonatomic) UIImageView *imageView;       //图片
@property (strong, nonatomic) NSString *imageURL;           //图片地址
//我的历史
@property (strong, nonatomic) UILabel *barcodeLabel;        //内部条形码
@property (strong, nonatomic) UILabel *typeLabel;           //操作类型

-(void)initBorrowCell;
-(void)initFavoriteCell;
-(void)initHistoryCell;

@end
