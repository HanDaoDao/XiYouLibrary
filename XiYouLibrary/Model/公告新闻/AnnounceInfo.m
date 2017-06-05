//
//  AnnounceInfo.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/6/1.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "AnnounceInfo.h"

@implementation AnnounceInfo

-(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"Data" : [AnnounceData class],
             @"Type" :@"Type",
             @"CurrentPage":@"CurrentPage",
             @"Pages":@"Pages",
             @"Amount":@"Amount"
             };
}

@end
