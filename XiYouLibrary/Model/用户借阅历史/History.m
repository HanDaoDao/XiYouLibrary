//
//  Borrow.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/5/31.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "History.h"

@implementation History

-(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"Detail" : HistoryDetail.class,
             @"Result" :@"Result"
             };
}

@end
