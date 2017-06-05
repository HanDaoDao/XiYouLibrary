//
//  Announce.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/6/1.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnnounceInfo.h"

@interface Announce : NSObject

@property(nonatomic,assign) Boolean Result;
@property(nonatomic,strong) AnnounceInfo *Detail;

@end
