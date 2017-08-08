//
//  Rating.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/31.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubanRating : NSObject

@property(nonatomic,strong) NSNumber *max;          //满分
@property(nonatomic,strong) NSNumber *numRaters;          //评分次数
@property(nonatomic,strong) NSNumber *average;          //平均分
@property(nonatomic,strong) NSNumber *min;          //最低分

@end

