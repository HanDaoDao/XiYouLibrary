//
//  Borrow.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/9.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "Borrow.h"

@implementation Borrow

-(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"Data" : [BorrowDetail class],
             @"Result" :@"Result"
             };
}

@end
