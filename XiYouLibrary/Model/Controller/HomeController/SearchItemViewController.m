//
//  SearchItemViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/18.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "SearchItemViewController.h"

@interface SearchItemViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>

@property(nonatomic,strong) UISearchController *searchController;
@property(nonatomic,strong) SearchResultViewController *searchResultVC;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy)   NSString *keyWords;
@property(nonatomic,strong) Book *book;
@property(nonatomic,strong) NSMutableArray *bookTitalArray;

@end

static NSString *const kReuseIdentifier = @"CellReuseIdentifier";

@implementation SearchItemViewController

-(NSMutableArray *)bookTitalArray{
    if (!_bookTitalArray) {
        _bookTitalArray = [[NSMutableArray alloc] init];
    }
    return _bookTitalArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    //设置navigationBar字体及颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.title = @"搜索图书";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    self.searchResultVC = [[SearchResultViewController alloc]init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //大小调整
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //设置更新代理
    self.searchController.searchResultsUpdater = self;
    
    //设置背景是否透明化
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    //搜索框右边是否显示一个书本的图标
    self.searchController.searchBar.showsBookmarkButton = YES;
    //点击searchBar之后仍然显示搜索框
    self.definesPresentationContext = YES;
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _bookTitalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuseIdentifier];
    }
    
    BookData *bookData = [_bookTitalArray objectAtIndex:indexPath.row];
    cell.textLabel.text = bookData.Title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultViewController *searchVC = [[SearchResultViewController alloc] init];
    BookData *bookDetail=self.bookTitalArray[indexPath.row];
    searchVC.bookData = bookDetail;
    searchVC.title = bookDetail.Title;
    searchVC.view.backgroundColor = [UIColor whiteColor];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - UISearchResultsUpdating

static int a = 0;
/**实现更新代理*/
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    _keyWords = self.searchController.searchBar.text;
    NSLog(@"%@",_keyWords);
    [self searchBook];
    NSLog(@"%d次",a);
    a++;
}

#pragma mark - UISearchBarDelegate
/**点击按钮后，进行搜索页更新*/
//-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
//{
//    [self updateSearchResultsForSearchController:self.searchController];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBook{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/book/search";
    AFHTTPSessionManager *searchManager = [AFHTTPSessionManager manager];
    searchManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    searchManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *params = @{@"keyword":_keyWords};
    
    [searchManager GET:urlstr
            parameters:params
            progress:^(NSProgress * _Nonnull downloadProgress) {

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"Yes");
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                
//                NSLog(@"%@",resultDic);
                
                self.book = [Book yy_modelWithJSON:resultDic];
                
                [self.book.Detail.BookData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dataDic = obj;
                    BookData *bd = [BookData yy_modelWithJSON:dataDic];
                    [self.bookTitalArray addObject:bd];
                }];
                [self.tableView reloadData];

                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"No");
            }];

}

@end
