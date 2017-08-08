//
//  HomeViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/2/17.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIButton *liftButton;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UIButton *tempButton;
@property(nonatomic,strong)UIScrollView *homeScrollView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UISwipeGestureRecognizer *recognizer;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = searchButton;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];

    //设置navigationBar字体及颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    //设置点击cell后的返回按钮的文字
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    //初始化按钮
    [self initButton];
    //初始化ScrollView,TableView
    [self setupChildControllers];
    [self initBackGroundView];
    [self scrollViewDidEndScrollingAnimation:_homeScrollView];
    
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}


//初始化按钮
-(void)initButton{
    //公告按钮
    _liftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _liftButton.tag = 100;
    _liftButton.selected = YES;
    _tempButton = _liftButton;
    _liftButton.backgroundColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    [_liftButton setTitle:@"公告" forState:UIControlStateNormal];
    [_liftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_liftButton setBackgroundImage:[UIImage imageNamed:@"按钮选中背景"] forState:UIControlStateSelected];
    [self.view addSubview:_liftButton];
    
    //通知按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.tag = 101;
    _rightButton.backgroundColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"按钮选中背景"] forState:UIControlStateSelected];
    [_rightButton setTitle:@"新闻" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_rightButton];
    
    //添加两个按钮的点击事件
    [_liftButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];

    
    //两个按钮的约束
    [_liftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.06);
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.06);
    }];
}

//按钮点击事件
-(void)buttonSelected:(UIButton *)sender{

    if (sender!=_tempButton) {
        sender.selected = YES;
        _tempButton.selected = NO;
        _tempButton =sender;
        [UIView animateWithDuration:0.3 animations:^{

            _homeScrollView.contentOffset = CGPointMake((sender.tag-100)*WIDTH, 0);
            [self scrollViewDidEndScrollingAnimation:_homeScrollView];

        }];
        
    }
}

//navigationBar搜索按钮点击事件
-(void)searchAction{
    SearchItemViewController *searchItemVC = [[SearchItemViewController alloc]init];
    searchItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchItemVC animated:YES];
}

//初始化ScrollView,TableView
-(void)initBackGroundView{
    
    _homeScrollView = [[UIScrollView alloc] init];
    //设置ScrollView内容展示的大小
    _homeScrollView.contentSize = CGSizeMake(WIDTH * 2 , 0);
    _homeScrollView.bounces = NO;
    _homeScrollView.showsVerticalScrollIndicator = NO;
    _homeScrollView.pagingEnabled = YES;
    _homeScrollView.delegate = self;
    [self.view addSubview:_homeScrollView];
    
    [_homeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_liftButton.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
}

-(void)setupChildControllers{
    NoticeTableViewController *noticeTableVC = [[NoticeTableViewController alloc] init];
    [self addChildViewController:noticeTableVC];
    NewsTableViewController *newsTableVC = [[NewsTableViewController alloc] init];
    [self addChildViewController:newsTableVC];
}

#pragma mark - UIScrollerViewDelegate
//scrollview 的协议方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / WIDTH;
    NSLog(@"%ld",(long)index);
    UITableViewController *tableVC = self.childViewControllers[index];
    tableVC.tableView.frame = CGRectMake(index * WIDTH, 0, WIDTH, HEIGHT);
    [self.homeScrollView addSubview:tableVC.tableView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:_homeScrollView];
    float sub = _homeScrollView.contentOffset.x/WIDTH;
    
    UIButton * btn = (UIButton * )[self.view viewWithTag:sub+100];
    
    if ( _tempButton != btn) {
        btn.selected = YES;
        _tempButton.selected = NO;
        _tempButton =btn;
        
    }
}


@end
