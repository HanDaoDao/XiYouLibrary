//
//  LoginResult.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/5/16.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginResult : NSObject
@property Boolean Result;
@property NSMutableString *Detail;

+(LoginResult *)ShareInstance;

@end
