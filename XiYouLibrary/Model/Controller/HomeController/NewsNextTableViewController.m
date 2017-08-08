//
//  NewsNextTableViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/6/19.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "NewsNextTableViewController.h"
#import "AFNetworking.h"


@interface NewsNextTableViewController ()

@property(nonatomic,strong) AnnounceDetail* announceDetail;

@end

@implementation NewsNextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    [self getNewsDetail];
    
    //显示HUD
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
}

-(void)initWebView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-60)];
    
    //自动调整view的高度，以保证上边距和下边距不变
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_webView loadHTMLString:_announceDetail.Detail.Passage baseURL:nil];
    
    [self.view addSubview:_webView];
    
    [SVProgressHUD dismiss];

}

//网络请求获取公告详细信息
-(void)getNewsDetail{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/news/getDetail/news/html/";
    urlstr = [NSString stringWithFormat:@"%@%@",urlstr,_annouceDate.ID];
    AFHTTPSessionManager *detailManager = [AFHTTPSessionManager manager];
    detailManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    detailManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"%@",urlstr);
    
    [detailManager GET:urlstr
            parameters:nil
              progress:^(NSProgress * _Nonnull downloadProgress) {
                  
              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSLog(@"请求公告成功");
                  NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//                  NSLog(@"%@",resultDic);
                  
                  //YYModel进行JSON转Model
                  _announceDetail = [AnnounceDetail yy_modelWithJSON:resultDic];
                  NSLog(@"~~~~~~~~~~~~~~~~~~~");
                  
                  [self initWebView];
                  
                  
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
              }];
}


@end
