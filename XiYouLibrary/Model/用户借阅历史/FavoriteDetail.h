//
//  FavoriteDetail.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/13.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteImage.h"

@interface FavoriteDetail : NSObject

@property(nonatomic,strong) NSString *Title;        //书名
@property(nonatomic,strong) NSString *Pub;          //出版社
@property(nonatomic,strong) NSString *Author;       //作者
@property(nonatomic,strong) NSString *Sort;         //索书号
@property(nonatomic,strong) NSString *ISBN;         //条形码
@property(nonatomic,strong) NSString *ID;           //图书馆内控制号
@property(nonatomic,strong) FavoriteImage *Images;  //图片来自豆瓣，可能为null

@end
