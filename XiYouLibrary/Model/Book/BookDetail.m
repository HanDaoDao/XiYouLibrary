//
//  BookDetail.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/19.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "BookDetail.h"

@implementation BookDetail

-(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"BookData" : BookData.class,
             @"Ammount" :@"Ammount",
             @"CurrentPage" :@"CurrentPage",
             @"Pages" :@"Pages",
             @"Size" :@"Size",
             @"Keyword" :@"Keyword",
             @"RecordType" :@"RecordType",
             @"KeywordType" :@"KeywordType",
             @"MatchType" :@"MatchType",
             @"OrderBy" :@"OrderBy",
             @"OrderSc" :@"OrderSc"
             };
}

@end
