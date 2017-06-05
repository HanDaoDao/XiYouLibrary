//
//  SettingNextViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/4/13.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "SettingNextViewController.h"

@interface SettingNextViewController ()

@property(nonatomic,strong) UITextView *textView;

@end

@implementation SettingNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _textView.scrollEnabled = YES;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _textView.font = [UIFont fontWithName:@"Gill Sans" size:18];
    _textView.text = @"我就是我，颜色不一样的烟火";
    
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
