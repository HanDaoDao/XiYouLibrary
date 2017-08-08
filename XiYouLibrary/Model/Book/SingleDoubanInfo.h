//
//  DoubanInfo.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/31.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoubanRating.h"
#import "DoubanImages.h"

//来自豆瓣的图书信息DoubanInfo
@interface SingleDoubanInfo : NSObject

@property(nonatomic,strong) DoubanRating *Rating;          //评分
@property(nonatomic,strong) NSString *Author;          //作者
@property(nonatomic,strong) NSString *PubDate;          //出版日期
@property(nonatomic,strong) NSString *Binding;          //装订类型
@property(nonatomic,strong) NSString *Pages;          //页数
@property(nonatomic,strong) DoubanImages *Images;          //图片
@property(nonatomic,strong) NSString *Publisher;          //出版社
@property(nonatomic,strong) NSString *ISBN10;          //10号标准
@property(nonatomic,strong) NSString *ISBN13;          //13号标准
@property(nonatomic,strong) NSString *Title;          //书名
@property(nonatomic,strong) NSString *Alt_Title;          //副标题
@property(nonatomic,strong) NSString *Author_Info;          //作者信息
@property(nonatomic,strong) NSString *Summary;          //图书简介
@property(nonatomic,strong) NSString *Price;          //价格


@end
