//
//  AnnounceInfo.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/6/1.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnnounceData.h"

@interface AnnounceInfo : NSObject

@property(nonatomic,strong) NSString* Type;
@property(nonatomic,assign) NSInteger* CurrentPage;
@property(nonatomic,assign) NSInteger* Pages;
@property(nonatomic,assign) NSString* Amount;
@property(nonatomic,strong) NSArray* Data;


@end
