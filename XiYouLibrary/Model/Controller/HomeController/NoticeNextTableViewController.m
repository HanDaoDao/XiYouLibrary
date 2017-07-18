//
//  NoticeNextTableViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/6/5.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "NoticeNextTableViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"

@interface NoticeNextTableViewController ()

@property(nonatomic,strong) AnnounceDetail* announceDetail;

@end

@implementation NoticeNextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    [self getNoticeDetail];
}

-(void)initWebView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-60)];
    
    //自动调整view的高度，以保证上边距和下边距不变
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [_webView loadRequest:_announceDetail.Detail.Passage];
    [_webView loadHTMLString:_announceDetail.Detail.Passage baseURL:nil];
    
    [self.view addSubview:_webView];
}

//网络请求获取公告详细信息
-(void)getNoticeDetail{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/news/getDetail/announce/html/";
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
//                    NSLog(@"%@",resultDic);
                    
                    //YYModel进行JSON转Model
                    _announceDetail = [AnnounceDetail yy_modelWithJSON:resultDic];
                    NSLog(@"~~~~~~~~~~~~~~~~~~~");
   
                    [self initWebView];

    
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
