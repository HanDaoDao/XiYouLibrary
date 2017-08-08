//
//  SearchResultViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/19.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@property(nonatomic,strong) SingleBook *singleBook;
@property(nonatomic,strong) NSMutableArray *circulationInfoDataArray;
@property(nonatomic,strong) NSMutableArray *referBooksDataArray;

@end

@implementation SearchResultViewController

//懒加载dataArray
-(NSMutableArray *)circulationInfoDataArray{
    if (!_circulationInfoDataArray) {
        _circulationInfoDataArray = [NSMutableArray array];
    }
    return _circulationInfoDataArray;
}

-(NSMutableArray *)referBooksDataArray{
    if (!_referBooksDataArray) {
        _referBooksDataArray = [NSMutableArray array];
    }
    return _referBooksDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableView];
    [self searchSingleBookDetail];
    
}

-(void)initTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
}



/**
    搜索到的图书根据ID或者条形码获取详细信息。
*/
-(void)searchSingleBookDetail{
    NSString *urlstr = @"http://api.xiyoumobile.com/xiyoulibv2/book/detail/id/";
    urlstr = [NSString stringWithFormat:@"%@%@",urlstr,_bookData.ID];
    AFHTTPSessionManager *bookDetailManager = [AFHTTPSessionManager manager];
    bookDetailManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    bookDetailManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [bookDetailManager GET:urlstr
            parameters:nil
              progress:^(NSProgress * _Nonnull downloadProgress) {
                  
              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSLog(@"Yes");
                  NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                  
                  NSLog(@"%@",resultDic);
                  
                  self.singleBook = [SingleBook yy_modelWithJSON:resultDic];
                  
                  [self.singleBook.Detail.CirculationInfo enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                      NSDictionary *dataDic = obj;
                      SingleCirculationInfo *sci = [SingleCirculationInfo yy_modelWithJSON:dataDic];
                      [self.circulationInfoDataArray addObject:sci];
                  }];
                  
                  [self.singleBook.Detail.ReferBooks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                      NSDictionary *dataDic = obj;
                      SingleReferBooks *srb = [SingleReferBooks yy_modelWithJSON:dataDic];
                      [self.referBooksDataArray addObject:srb];
                  }];
                  
                  [self.tableView reloadData];
                  
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"No");
              }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
