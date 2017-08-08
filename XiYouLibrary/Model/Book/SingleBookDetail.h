//
//  SingleBookDetail.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/30.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleCirculationInfo.h"
#import "SingleReferBooks.h"
#import "SingleDoubanInfo.h"

@interface SingleBookDetail : NSObject

@property(nonatomic,strong) NSString *ID;          //所查图书的ID
@property(nonatomic,strong) NSString *ISBN;          //所查图书的ISBN
@property(nonatomic,strong) NSString *SecondTitle;          //副标题
@property(nonatomic,strong) NSString *Pub;          //出版信息
@property(nonatomic,strong) NSString *Tilte;          //书名、主标题
@property(nonatomic,strong) NSString *Form;          //载体形态
@property(nonatomic,strong) NSString *Author;          //作者
@property(nonatomic,strong) NSString *Sort;          //中图分类号
@property(nonatomic,strong) NSString *Subject;          //主题

@property(nonatomic,strong) NSNumber *RentTimes;          //借阅次数
@property(nonatomic,strong) NSNumber *FavTimes;          //收藏次数
@property(nonatomic,strong) NSNumber *BrowseTimes;          //浏览次数
@property(nonatomic,strong) NSNumber *Total;          //藏书数量
@property(nonatomic,strong) NSNumber *Avaliable;          //可借数量
@property(nonatomic,strong) NSArray *CirculationInfo;          //流通信息数组
@property(nonatomic,strong) NSArray *ReferBooks;          //相关图书信息数组
@property(nonatomic,strong) NSArray *DoubanInfo;          //来自豆瓣的图书信息，若豆瓣数据库无该书信息则为null


@end
