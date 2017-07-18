//
//  MineNextViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/15.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "MineBorrowViewController.h"


@interface MineBorrowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) LoginResult *loginResult;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy)   NSString *session;
@property(nonatomic,strong) Borrow* borrow;
@property(nonatomic,strong) NSMutableArray* dataArray;

@end

@implementation MineBorrowViewController

//懒加载dataArray
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    _loginResult = [LoginResult ShareInstance];
    
    //从NSUserDefaults中提取session
    NSUserDefaults * Session = [NSUserDefaults standardUserDefaults];
     _session = [Session objectForKey:@"session"];
    NSLog(@"%@",_session);
    
    [self getUserBorrow];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    MineCell *view = [[MineCell alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
    [view initBorrowCell];
    
    BorrowDetail* a = [_dataArray objectAtIndex:indexPath.row];
    view.titleLabel.text = a.Title;
    view.departmentLabel.text = a.Department;
//    view.stateLabel.text = a.State;
    view.dateLabel.text = a.Date;
    if (a.CanRenew) {
//        view.stateButton.titleLabel.text = @"可续借";
        [view.stateButton.layer setBorderColor:[UIColor colorWithRed:115/255.0 green:175/255.0 blue:247/255.0 alpha:1].CGColor];
        [view.stateButton setTitle:@"可续借" forState:UIControlStateNormal];
        [view.stateButton setTintColor:[UIColor blackColor]];
        [view.stateButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [view.stateButton.layer setBorderColor:[UIColor redColor].CGColor];
        [view.stateButton setTitle:@"不可续借" forState:UIControlStateNormal];
        [view.stateButton setTintColor:[UIColor blackColor]];
        
        [view.stateButton setTag:indexPath.row];
        [view.stateButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    
    [cell.contentView addSubview:view];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击cell返回时，取消选择状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIColor *grayColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    cell.backgroundColor = indexPath.row % 2 ? [UIColor whiteColor]:grayColor;
}

-(void)buttonAction:(UIButton*)sender{
    NSLog(@"hhh%@",[_dataArray objectAtIndex:sender.tag]);
    BorrowDetail *bd = [_dataArray objectAtIndex:sender.tag];

    [self bookRenew:bd];
    
    
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

//                   NSLog(@"%@",resultDic);
                   _borrow = [Borrow yy_modelWithJSON:resultDic];

                   [_borrow.Detail enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                       NSDictionary *detaile = obj;
                       BorrowDetail *bd = [BorrowDetail yy_modelWithDictionary:detaile];
//                       NSLog(@"~~~~~~~~~%@~~~~~~~",bd);
                       [self.dataArray addObject:bd];
                   }];
                   [self.tableView reloadData];
//                   NSLog(@"%lu",(unsigned long)_dataArray.count);
                
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"请求失败！");
               }];

}

-(void)bookRenew:(BorrowDetail*)borrowDetail{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/user/renew";
    AFHTTPSessionManager *renewManager = [AFHTTPSessionManager manager];
    renewManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    renewManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *params = @{@"session":_session,
                             @"barcode":borrowDetail.Barcode,
//                             @"department_id":borrowDetail.Department_id,
//                             @"library_id":borrowDetail.Library_id
                             };
    
    [renewManager GET: urlstr
           parameters:params
             progress:^(NSProgress * _Nonnull downloadProgress) {
                 
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"yes");
                 UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"续借成功" message:@"到期时间：2017-9-10" preferredStyle:UIAlertControllerStyleAlert];
                 [alertController addAction:[UIAlertAction actionWithTitle:@"知道啦" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                 }]];
                 [self presentViewController:alertController animated:YES completion:nil];
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"no");
             }];
}



@end
