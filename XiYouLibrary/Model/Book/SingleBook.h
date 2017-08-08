//
//  SingleBook.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/30.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleBookDetail.h"

@interface SingleBook : NSObject

@property (nonatomic,assign) Boolean Result;
@property (nonatomic,strong) SingleBookDetail *Detail;

@end
