//
//  NewsTableViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/27.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "NewsTableViewController.h"
#import "homeTableViewCell.h"
#import "HomeNextViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "Announce.h"
#import "YYModel.h"

@interface NewsTableViewController ()

@property(nonatomic,strong) Announce* news;
@property(nonatomic,strong) NSMutableArray* dataArray;
@property(nonatomic,strong) AnnounceData* newsData;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //设置下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
}


//下拉刷新使用的方法
-(void)refresh{
    
    NSLog(@"哈哈哈");
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(targetMethod) userInfo:nil repeats:NO];
    
}

-(void)targetMethod{
    NSLog(@"关闭");
    
    //下拉刷新获取新闻信息
    [self getNews];
    [self.tableView.mj_header endRefreshing];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *indentifier = @"cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    for (int i = 0; i<cell.contentView.subviews.count; i++) {
        UIView *v = cell.contentView.subviews[i];
        [v removeFromSuperview];
    }
    cell.backgroundColor = [UIColor yellowColor];
    NSLog(@"%@",NSStringFromCGRect(cell.contentView.frame));
    homeTableViewCell *view = [[homeTableViewCell alloc]initWithFrame:CGRectMake(0, 0, 800, cell.contentView.frame.size.height)];
    view.backgroundColor = [UIColor redColor];
    
    view.label.text = [_dataArray objectAtIndex:indexPath.row];
    [cell.contentView addSubview:view];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *textViewText = [[NSArray alloc] initWithObjects:@"星期一！",@"卧槽",@"你猜",@"哈哈哈哈",@"嗯嗯嗯嗯嗯", nil];
    
    //点击cell返回时，取消选择状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    HomeNextViewController *homeNextViewController = [[HomeNextViewController alloc] init];
    homeNextViewController.hidesBottomBarWhenPushed = YES;
    homeNextViewController.textViewText = textViewText[indexPath.row];
    //    NSLog(@"%@",[textViewText objectAtIndex:indexPath.row]);
    
    [self.navigationController pushViewController:homeNextViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//网络请求获取公告信息
-(void)getNews{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/news/getList/news/1";
    AFHTTPSessionManager *newsManager = [AFHTTPSessionManager manager];
    newsManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    newsManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *params = @{@"type":@"news",
                             @"page":@"1"};
    
    [newsManager GET:urlstr
            parameters:params
            progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"请求新闻成功");
                    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//                    NSLog(@"%@",resultDic);
                    
                    //YYModel进行JSON转Model
                    _news = [Announce yy_modelWithJSON:resultDic];
                    NSLog(@"~~~~~~~~~~~~~~~~~~~");
                    _dataArray = [[NSMutableArray alloc]init];
                    
                    [_news.Detail.Data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSDictionary *dataDic = obj;
                        _newsData = [AnnounceData yy_modelWithDictionary:dataDic];
                        NSString *title = [_newsData valueForKey:@"Title"];
                        [_dataArray addObject:title];
                    }];
                    [self.tableView reloadData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
}

@end
