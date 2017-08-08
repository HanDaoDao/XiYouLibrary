//
//  Book.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/19.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookDetail.h"

@interface Book : NSObject

@property (nonatomic,assign) Boolean Result;
@property (nonatomic,strong) BookDetail *Detail;

@end
