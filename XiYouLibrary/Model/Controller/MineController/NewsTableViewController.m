//
//  NewsTableViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/27.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsNextTableViewController.h"
#import "homeTableViewCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "Announce.h"
#import "YYModel.h"

@interface NewsTableViewController ()

@property(nonatomic,strong) Announce* news;
@property(nonatomic,strong) NSMutableArray* dataArray;

@end

@implementation NewsTableViewController

//懒加载dataArray
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //当刚开始没有数据的时候，不显示cell
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
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

    homeTableViewCell *view = [[homeTableViewCell alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    [view initView];

    AnnounceData* a = [_dataArray objectAtIndex:indexPath.row];
    view.label.text = a.Title;
    [cell.contentView addSubview:view];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //点击cell返回时，取消选择状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NewsNextTableViewController *newsNextViewController = [[NewsNextTableViewController alloc] init];
    newsNextViewController.hidesBottomBarWhenPushed = YES;
    AnnounceData* annouce = [_dataArray objectAtIndex:indexPath.row];
    newsNextViewController.annouceDate = annouce;
    [self.navigationController pushViewController:newsNextViewController animated:YES];
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
                    
                    [_news.Detail.Data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSDictionary *dataDic = obj;
                        AnnounceData* nd = [AnnounceData yy_modelWithDictionary:dataDic];
                        [self.dataArray addObject:nd];
                    }];
                    [self.tableView reloadData];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
}

@end
