//
//  UserInfo.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/5/22.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

static UserInfo *userInfo = nil;

+(UserInfo *)ShareInstance{
    if (userInfo == nil) {
        userInfo = [[UserInfo alloc] init];
    }
    return userInfo;
}

@end
