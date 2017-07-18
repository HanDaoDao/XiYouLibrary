//
//  BorrowInfo.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/5/31.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryDetail : NSObject

@property(nonatomic,copy) NSString *Title;      //书名
@property(nonatomic,copy) NSString *Barcode;    //内部条形码
@property(nonatomic,copy) NSString *Type;       //操作类型，分为：借书、续借、还书
@property(nonatomic,strong) NSString *Date;       //操作日期

@end
