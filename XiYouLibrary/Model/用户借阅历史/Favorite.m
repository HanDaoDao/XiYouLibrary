//
//  Favorite.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/13.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "Favorite.h"

@implementation Favorite

-(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"Detail" : FavoriteDetail.class,
             @"Result" :@"Result"
             };
}

@end
