//
//  UserInfo.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/5/22.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserInfo : NSObject

@property (nonatomic,assign)Boolean Result;     //返回是否成功值
@property(nonatomic,strong) User *Detail;       //返回的是用户信息

+(UserInfo *)ShareInstance;

@end
