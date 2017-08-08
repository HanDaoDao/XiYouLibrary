//
//  NoticeNextTableViewController.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/6/5.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Announce.h"
#import "AnnounceDetail.h"
#import "YYModel.h"
#import "SVProgressHUD.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface NoticeNextTableViewController : UIViewController

@property(nonatomic,strong) UIWebView *webView;
@property(nonatomic,strong) AnnounceData* annouceDate;

@end
