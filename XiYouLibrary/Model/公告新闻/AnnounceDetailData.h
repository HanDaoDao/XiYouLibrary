//
//  AnnounceDetailData.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/6/6.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnounceDetailData : NSObject

@property(nonatomic,strong) NSString* Title;            //标题
@property(nonatomic,assign) NSString* Publisher;        //发布者
@property(nonatomic,strong) NSDate* Date;               //发布日期
@property(nonatomic,strong) NSString* Passage;          //正文

@end
