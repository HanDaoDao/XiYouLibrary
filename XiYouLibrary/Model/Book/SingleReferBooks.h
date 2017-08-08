//
//  ReferBooks.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/31.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>

//相关图书信息数组
@interface SingleReferBooks : NSObject

@property(nonatomic,strong) NSString *ID;          //控制号
@property(nonatomic,strong) NSString *Title;          //书名
@property(nonatomic,strong) NSString *Author;          //作者

@end
