//
//  BorrowDetail.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/9.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BorrowDetail : NSObject

@property(nonatomic,strong) NSString *Title;        //书名
@property(nonatomic,strong) NSString *Barcode;      //图书馆内部条形码
@property(nonatomic,strong) NSString *Department;   //所在分馆
@property(nonatomic,strong) NSString *State;        //当前状态
@property(nonatomic,strong) NSString *Date;         //应还日期
@property(nonatomic,assign) Boolean *CanRenew;      //是否可续借
@property(nonatomic,assign) NSNumber *Department_id;     //书库ID号，用于续借
@property(nonatomic,assign) NSNumber *Library_id;        //分馆ID号，用于续借

@end
