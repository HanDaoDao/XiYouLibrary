//
//  MainViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/2/17.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "MineViewController.h"
#import "homeTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "LoginResult.h"
#import "UserInfo.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIButton *loginButton;
@property(nonatomic,strong) UITableView *mineTableView;
@property(nonatomic,strong) NSArray *mineListNames;
@property(nonatomic,strong) NSString *loginUserName;
@property(nonatomic,strong) NSString *loginPassword;
@property(nonatomic,strong) LoginResult *loginResult;
@property(nonatomic,strong) UserInfo* userInfo;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏的背景色（图片）
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    
    //设置navigationBar字体及颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    _loginResult = [LoginResult ShareInstance];


    if (_loginResult.Result == 0) {
        [self initMineLoginView];

    }
    else if(_loginResult.Result == 1){
        //初始化Mine的tableView
        [self initMineListNames];
        [self initMineTableView];
    }
    
}
//未登录之前，界面只有一个登录按钮
-(void)initMineLoginView{
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _loginButton.backgroundColor = [UIColor redColor];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(HEIGHT/3);
        make.left.equalTo(self.view.mas_left).offset(WIDTH/2.5);
        make.right.equalTo(self.view.mas_right).offset(-WIDTH/2.5);
        make.height.mas_equalTo(50);
    }];
}

//登录之后,初始化我的个人信息
-(void)initMineListNames{
        _mineListNames = @[@"我的借阅",@"我的收藏",@"我的足迹"];
}

-(void)initMineTableView{
    
    
    _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStyleGrouped];
    _mineTableView.dataSource = self;
    _mineTableView.delegate = self;
    
    [self.view addSubview:_mineTableView];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;  {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : [_mineListNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    mineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (cell == nil) {
        cell = [[mineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    
    if (indexPath.section == 0) {
        [cell initMineInformationCell];
        cell.nameLabel.text = _userInfo.Detail.Name;
        cell.majorLabel.text = _userInfo.Detail.Department;
        cell.IDLabel.text = _userInfo.Detail.ID;
    }
    else{
        [cell initMineCell];
        cell.cellLabel.text = [_mineListNames objectAtIndex:indexPath.row];

    }
    
    return cell;
}


//#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MineNextViewController *mineNextViewController = [[MineNextViewController alloc] init];
    mineNextViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mineNextViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0? 80:44;
}

//网络请求
//http://api.xiyoumobile.com/xiyoulibv2/user/login
-(void)getLoginSession{
    
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/user/login";
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    NSDictionary *params = @{@"username":_loginUserName,
//                             @"password":_loginPassword};
    NSDictionary *params = @{@"username":@"04151010",
                             @"password":@"151010"};
    
    [sessionManager GET:urlstr
             parameters:params
               progress:^(NSProgress * _Nonnull downloadProgress) {
                   
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   NSLog(@"成功了！");
                   
                   NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                   
                   /*
                    **        _loginResult.Detail 即为session！！！
                    */
                   
//                   _loginResult.Detail= [[NSMutableString alloc] initWithString:[resultDic objectForKey:@"Detail"]];
                   
                   _loginResult = [LoginResult yy_modelWithJSON:resultDic];
                   NSLog(@"%hhu",_loginResult.Result);
                   NSLog(@"%@",_loginResult.Detail);
                   
                   if (_loginResult.Result == 1) {
                       
                       //参数在传的时候，前面需要加上session=，在path前面还要加上%20；

                       [_loginResult.Detail insertString:@"%20" atIndex:44];
                       NSLog(@"%@",_loginResult.Detail);
                       
                       //NSUserDefaults 保存用户名密码
                       NSUserDefaults *userName = [NSUserDefaults standardUserDefaults];
                       [userName setObject:_loginUserName forKey:@"loginUserName"];
                       NSUserDefaults *passWord = [NSUserDefaults standardUserDefaults];
                       [passWord setObject:_loginPassword forKey:@"loginPassword"];
                       NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
                       [session setObject:_loginResult.Detail forKey:@"session"];
                       
                       [self getUserInfo];
                   }
                   
                   else{
                       NSLog(@"咋回事吗");
                   }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"请求失败！");
               }];
}

-(void)getUserInfo{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/user/info";
    AFHTTPSessionManager *infoManager = [AFHTTPSessionManager manager];
    infoManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    infoManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *params = @{@"session":_loginResult.Detail};
    
    [infoManager GET:urlstr
          parameters:params
            progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"请求用户数据成功！！");
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                
                _userInfo = [UserInfo yy_modelWithJSON:resultDic];
                NSLog(@"%@",resultDic);

                NSLog(@"%hhu",_userInfo.Result);
                _userInfo.Detail.ID = [_userInfo.Detail.ID substringFromIndex:0];
                NSLog(@"%@",_userInfo.Detail.ID);
                NSLog(@"%@",_userInfo.Detail.Name);
                
                if (_userInfo.Result == 1) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //删除登录按钮
                        [self.loginButton removeFromSuperview];
                        
                        //初始化Mine的tableView
                        [self initMineListNames];
                        [self initMineTableView];
                    });
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求用户数据失败！！");

            }];
}

//登录弹出框
-(void)loginEvent{
    UIAlertController *loginAlter = [UIAlertController alertControllerWithTitle:@"登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [loginAlter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"用户名";
    }];
    
    [loginAlter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];
    
    [loginAlter addAction:[UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _loginUserName = loginAlter.textFields.firstObject.text;
        _loginPassword = loginAlter.textFields.lastObject.text;
        
        
        //给账号之前加“S”
        _loginUserName = [NSString stringWithFormat:@"S%@",_loginUserName];
        NSLog(@"%@",_loginUserName);
        NSLog(@"%@",_loginPassword);
        [self getLoginSession];
        
    }]];
    
    [loginAlter addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    
    [self presentViewController:loginAlter animated:YES completion:nil];
}

@end
