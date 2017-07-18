//
//  NewsNextTableViewController.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/6/19.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Announce.h"
#import "AnnounceDetail.h"
#import "YYModel.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface NewsNextTableViewController : UIViewController

@property(nonatomic,strong) UIWebView *webView;
@property(nonatomic,strong) AnnounceData* annouceDate;

@end
