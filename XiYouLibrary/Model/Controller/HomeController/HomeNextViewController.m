//
//  HomeNextViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/3/18.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "HomeNextViewController.h"

@interface HomeNextViewController ()

@end

@implementation HomeNextViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];

    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    //可以滑动
    _textView.scrollEnabled = YES;
    //自动调整view的高度，以保证上边距和下边距不变
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _textView.font = [UIFont fontWithName:@"Gill Sans" size:18];
//    _textView.text = @"你才炸了，你全家都炸了！！";
    _textView.text = self.textViewText;
    
    [self.view addSubview:_textView];
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
