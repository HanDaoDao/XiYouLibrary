//
//  SearchResultViewController.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/19.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleBook.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "YYModel.h"
#import "BookData.h"


#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SearchResultViewController : UIViewController

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) BookData* bookData;

@end
