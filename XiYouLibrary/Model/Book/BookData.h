//
//  BookData.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/19.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookImage.h"

@interface BookData : NSObject

@property(nonatomic,strong) NSString *ID;             //图书馆内部控制号
@property(nonatomic,strong) NSString *Title;          //书名，题目
@property(nonatomic,strong) NSString *Author;         //责任者，作者
@property(nonatomic,strong) NSString *Pub;            //出版社
@property(nonatomic,strong) NSString *ISBN;           //标准号
@property(nonatomic,strong) NSString *Year;           //出版年
@property(nonatomic,strong) NSString *Sort;           //图书馆索书号
@property(nonatomic,strong) NSNumber *Total;          //图书馆藏书数量
@property(nonatomic,strong) NSNumber *Available;      //可借阅数量
@property(nonatomic,strong) BookImage *Images;        //封面图片（可能为null


@end
