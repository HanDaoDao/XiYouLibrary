//
//  BookDetail.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/19.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookData.h"

@interface BookDetail : NSObject

@property(nonatomic,strong) NSNumber *Ammount;        //所查询到的图书信息总数
@property(nonatomic,strong) NSNumber *CurrentPage;    //当前页码
@property(nonatomic,strong) NSNumber *Pages;          //总页数
@property(nonatomic,strong) NSNumber *Size;           //本页图书信息数量

@property(nonatomic,strong) NSString *Keyword;          //检索关键词
@property(nonatomic,strong) NSString *RecordType;       //资料类型
@property(nonatomic,strong) NSString *KeywordType;      //检索词类别
@property(nonatomic,strong) NSString *MatchType;        //匹配方式
@property(nonatomic,strong) NSString *OrderBy;          //排序依据
@property(nonatomic,strong) NSString *OrderSc;          //排序顺序
@property(nonatomic,strong) NSArray *BookData;          //图书信息数组


@end
