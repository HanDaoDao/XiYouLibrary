//
//  MineNextViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/15.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "MineNextViewController.h"

@interface MineNextViewController ()

@property(nonatomic,strong) LoginResult *loginResult;
@property(nonatomic,copy) NSString *session;
@property(nonatomic,strong) Borrow* borrow;

@end

@implementation MineNextViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _loginResult = [LoginResult ShareInstance];
//    NSLog(@"%@",_loginResult);
    
    //从NSUserDefaults中提取session
    NSUserDefaults * Session = [NSUserDefaults standardUserDefaults];
     _session = [Session objectForKey:@"session"];
    NSLog(@"%@",_session);
    
    [self getUserBorrow];
}

-(void)getUserBorrow{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/user/rent";
    AFHTTPSessionManager *rentManager = [AFHTTPSessionManager manager];
    rentManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    rentManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *params = @{@"session":_session};
    
    [rentManager GET:urlstr
                 parameters:params
                 progress:^(NSProgress * _Nonnull downloadProgress) {
                   
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   NSLog(@"成功了！");
                   NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

                   NSLog(@"%@",resultDic);
                   _borrow = [Borrow yy_modelWithJSON:resultDic];
                   NSLog(@"%hhu",_borrow.Result);
                   NSLog(@"%@",_borrow.Detail);
                
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"请求失败！");
               }];

}

@end
