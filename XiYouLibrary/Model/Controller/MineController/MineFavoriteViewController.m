//
//  MineCollectionViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/13.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "MineFavoriteViewController.h"

@interface MineFavoriteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) LoginResult *loginResult;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy)   NSString *session;
@property(nonatomic,strong) Favorite *favorite;
@property(nonatomic,strong) NSMutableArray* dataArray;

@end

@implementation MineFavoriteViewController

//懒加载dataArray
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    _loginResult = [LoginResult ShareInstance];
    
    //从NSUserDefaults中提取session
    NSUserDefaults * Session = [NSUserDefaults standardUserDefaults];
    _session = [Session objectForKey:@"session"];
    NSLog(@"%@",_session);
    
    //显示HUD
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
    [self getUserFavorite];
    [self initTableView];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //当刚开始没有数据的时候，不显示cell
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    for (int i = 0; i<cell.contentView.subviews.count; i++) {
        UIView *v = cell.contentView.subviews[i];
        [v removeFromSuperview];
    }
    MineCell *view = [[MineCell alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    
    [view initFavoriteCell];
    
    FavoriteDetail* a = [_dataArray objectAtIndex:indexPath.row];
    view.titleLabel.text = a.Title;
    view.pubLabel.text = a.Pub;
    view.authorLabel.text = a.Author;
    view.sortLabel.text = a.Sort;
    view.imageURL = a.Images.medium;
    [cell.contentView addSubview:view];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击cell返回时，取消选择状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIColor *grayColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    cell.backgroundColor = indexPath.row % 2 ? [UIColor whiteColor]:grayColor;
}

-(void)getUserFavorite{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/user/favorite";
    AFHTTPSessionManager *favoriteManager = [AFHTTPSessionManager manager];
    favoriteManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    favoriteManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *params = @{@"session":_session};
    
    [favoriteManager GET:urlstr
                     parameters:params
                     progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"成功了！");
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                
                NSLog(@"%@",resultDic);
                _favorite = [Favorite yy_modelWithJSON:resultDic];
                
                [_favorite.Detail enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *detaile = obj;
                    FavoriteDetail *bd = [FavoriteDetail yy_modelWithDictionary:detaile];
                    [self.dataArray addObject:bd];
                }];
                
                [SVProgressHUD dismiss];
                [self.tableView reloadData];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败！");
            }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
