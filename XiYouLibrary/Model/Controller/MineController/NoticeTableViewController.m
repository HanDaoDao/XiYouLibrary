//
//  NoticeTableViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/27.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "NoticeTableViewController.h"
#import "homeTableViewCell.h"
#import "HomeNextViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "Announce.h"
#import "YYModel.h"

@interface NoticeTableViewController ()

@property(nonatomic,strong) Announce* announce;
@property(nonatomic,strong) NSMutableArray* dataArray;
@property(nonatomic,strong) AnnounceData* announceData;

@end

@implementation NoticeTableViewController

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
    
    //下拉刷新请求公告信息
    [self getNoticeInfo];
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
    homeTableViewCell *view = [[homeTableViewCell alloc]initWithFrame:CGRectMake(0, 0, WIDTH, cell.contentView.frame.size.height)];
//    view.backgroundColor = [UIColor redColor];
    
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
-(void)getNoticeInfo{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/news/getList/announce/1";
    AFHTTPSessionManager *announceManager = [AFHTTPSessionManager manager];
    announceManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    announceManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *params = @{@"type":@"announce",
                             @"page":@"1"};
    
    [announceManager GET:urlstr
            parameters:params
            progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"请求公告成功");
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//                NSLog(@"%@",resultDic);

                //YYModel进行JSON转Model
                _announce = [Announce yy_modelWithJSON:resultDic];
                NSLog(@"~~~~~~~~~~~~~~~~~~~");
                _dataArray = [[NSMutableArray alloc]init];
                
                [_announce.Detail.Data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dataDic = obj;
                    _announceData = [AnnounceData yy_modelWithDictionary:dataDic];
                    NSString *title = [_announceData valueForKey:@"Title"];
                    [_dataArray addObject:title];
                }];
                [self.tableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
