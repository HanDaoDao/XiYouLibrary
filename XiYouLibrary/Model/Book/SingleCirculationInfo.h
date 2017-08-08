//
//  CirculationInfoList.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/31.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>

//流通信息数组
@interface SingleCirculationInfo : NSObject

@property(nonatomic,strong) NSString *Barcode;          //条形码
@property(nonatomic,strong) NSString *Sort;          //索书号
@property(nonatomic,strong) NSString *Department;          //所在部门
@property(nonatomic,strong) NSString *Status;          //状态
@property(nonatomic,strong) NSString *Date;          //应还日期，可借则为null

@end
