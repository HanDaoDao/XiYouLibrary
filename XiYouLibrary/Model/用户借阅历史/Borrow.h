//
//  Borrow.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/9.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BorrowDetail.h"

@interface Borrow : NSObject

@property (nonatomic,assign) Boolean Result;
@property (nonatomic,strong) NSArray *Detail;

@end
