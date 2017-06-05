//
//  HomeNextViewController.h
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/3/18.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <UIKit/UIKit.h>


#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface HomeNextViewController : UIViewController

@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) NSString *textViewText;

@end
