//
//  XYTabBarController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/2/17.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "XYTabBarController.h"

@interface XYTabBarController ()<UITabBarControllerDelegate>

@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    
    //将顶部状态栏改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //将玻璃效果去掉
    self.tabBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTabBarController];
    
}

-(void)initTabBarController{
    
    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor colorWithRed:243/255.0 green:92/255.0 blue:90/255.0 alpha:1];
//    self.tabBar.barTintColor = [UIColor whiteColor];
    
    HomeViewController *HomeVC = [[HomeViewController alloc] init];
    HomeVC.title = @"首页";
    UINavigationController *HomeNC = [[UINavigationController alloc] initWithRootViewController:HomeVC];
    
    MineViewController *MineVC = [[MineViewController alloc] init];
    MineVC.title = @"我的";
    UINavigationController *MineNC = [[UINavigationController alloc] initWithRootViewController:MineVC];
    
    SettingViewController *SettingVC = [[SettingViewController alloc] init];
    SettingVC.title = @"设置";
    UINavigationController *SettingNC = [[UINavigationController alloc] initWithRootViewController:SettingVC];
    
    NSArray *nvcArray = @[HomeNC, MineNC, SettingNC];
    self.viewControllers = nvcArray;
    
    //设置tabBarItem的选中和非选中图片
    UITabBarItem *barItem0 = [[UITabBarItem alloc] initWithTitle:@"首页"image:[[UIImage imageNamed:@"首页-白色"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:0];
    barItem0.selectedImage = [[UIImage imageNamed:@"首页-按下-白色"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [HomeVC.navigationController setTabBarItem:barItem0];
    
    UITabBarItem *barItem1 = [[UITabBarItem alloc] initWithTitle:@"我的"image:[[UIImage imageNamed:@"我的-白色"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:1];
    barItem1.selectedImage = [[UIImage imageNamed:@"我的-按下-白色"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [MineVC.navigationController setTabBarItem:barItem1];

    UITabBarItem *barItem2 = [[UITabBarItem alloc] initWithTitle:@"设置"image:[[UIImage imageNamed:@"设置-白色"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:2];
    barItem2.selectedImage = [[UIImage imageNamed:@"设置-按下-白色"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [SettingVC.navigationController setTabBarItem:barItem2];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
