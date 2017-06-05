//
//  User.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/5/22.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,strong)NSString* ID;           //学号
@property (nonatomic,copy)NSString *Name;           //姓名
@property (nonatomic,copy)NSString* Department;     //专业
@property (nonatomic,strong)NSDate* From;           //有效开始日期
@property (nonatomic,strong)NSDate* To;             //有效截止日期
@property (nonatomic,copy)NSString* ReaderType;     //用户类别
@property double Debt;                              //欠费金额

@end

