//
//  LoginResult.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/5/16.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "LoginResult.h"

@implementation LoginResult

static LoginResult *loginResult = nil;

+(LoginResult *)ShareInstance{
    if (loginResult == nil) {
        loginResult = [[LoginResult alloc] init];
    }
    return loginResult;
}

@end
