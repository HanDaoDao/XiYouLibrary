//
//  MineCell.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/7/13.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

-(void)initBorrowCell{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont fontWithName:@"Gill Sans" size:18];
    //    _titleLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_titleLabel];
    
    _departmentLabel = [[UILabel alloc]init];
    _departmentLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
    //    _departmentLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:_departmentLabel];
    
//    _stateLabel = [[UILabel alloc]init];
//    _stateLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
//    //    _stateLabel.backgroundColor = [UIColor blueColor];
//    [self addSubview:_stateLabel];
    
    _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _stateButton.titleLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
    
    [_stateButton.layer setBorderColor:[UIColor colorWithRed:115/255.0 green:175/255.0 blue:247/255.0 alpha:1].CGColor];
    [_stateButton.layer setCornerRadius:5];
    [_stateButton.layer setBorderWidth:1];
    [_stateButton.layer setMasksToBounds:YES];
    
    [_stateButton setTitle:@"" forState:UIControlStateNormal];
    [_stateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_stateButton];
    
    UILabel* expireLabel = [[UILabel alloc]init];
    expireLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
    //    expireLabel.backgroundColor = [UIColor redColor];
    expireLabel.text = @"到期时间";
    [self addSubview:expireLabel];
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
    [self addSubview:_dateLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.height.mas_equalTo(24);
    }];
    
    [_departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.mas_equalTo(18);
    }];
    
//    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_titleLabel.mas_bottom);
//        make.left.equalTo(_departmentLabel.mas_right);
//        make.right.equalTo(self.mas_right).offset(-8);
//        make.height.mas_equalTo(18);
//    }];
    
    [_stateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(_departmentLabel.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [expireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departmentLabel.mas_bottom);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.mas_equalTo(56);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(expireLabel.mas_right);
        make.top.equalTo(_departmentLabel.mas_bottom);
        make.right.equalTo(self.mas_right).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];
}

-(void)initFavoriteCell{
    
    _imageView = [[UIImageView alloc]init];
    //_imageView.backgroundColor = [UIColor redColor];
    [self addSubview:_imageView];

    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 10;
//    NSString *url = @"http://statics.juxia.com/uploadfile/content/2014/3/2014032614324174.jpg";
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_imageURL]];
        UIImage *image = [UIImage imageWithData:data];
        if (image != nil ) {
            [self performSelectorOnMainThread:@selector(updateImage:) withObject:image waitUntilDone:YES];
        }
        else{
            self.imageView.image = [UIImage imageNamed:@"女帝"];
            NSLog(@"下载图片失败");
        }
    }];
    [queue addOperation:operation];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont fontWithName:@"Gill Sans" size:20];
    //_titleLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_titleLabel];
    
    _pubLabel = [[UILabel alloc]init];
    _pubLabel.font = [UIFont fontWithName:@"Gill Sans" size:14];
//    _pubLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:_pubLabel];
    
    _sortLabel = [[UILabel alloc]init];
    _sortLabel.font = [UIFont fontWithName:@"Gill Sans" size:14];
//    _sortLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:_sortLabel];
    
    _authorLabel = [[UILabel alloc]init];
    _authorLabel.font = [UIFont fontWithName:@"Gill Sans" size:14];
//    _authorLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_authorLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.mas_equalTo(70);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.left.equalTo(_imageView.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.mas_equalTo(30);
    }];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(_imageView.mas_right).offset(8);
        make.width.equalTo(self.mas_width).multipliedBy(0.45);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [_sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(_authorLabel.mas_right);
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [_pubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_authorLabel.mas_bottom);
        make.left.equalTo(_imageView.mas_right).offset(8);
        make.right.equalTo(self.mas_right).offset(-8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];
}

-(void)initHistoryCell{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont fontWithName:@"Gill Sans" size:18];
    //_titleLabel.backgroundColor = [UIColor redColor];
    [self addSubview:_titleLabel];
    
    UILabel* barLabel = [[UILabel alloc]init];
    barLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
    //barLabel.backgroundColor = [UIColor redColor];
    barLabel.text = @"内部条形码:";
    [self addSubview:barLabel];
    
    _barcodeLabel = [[UILabel alloc]init];
    _barcodeLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
    //_barcodeLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:_barcodeLabel];
    
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
    //_typeLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:_typeLabel];
    
    UILabel* expireLabel = [[UILabel alloc]init];
    expireLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
    //expireLabel.backgroundColor = [UIColor redColor];
    expireLabel.text = @"到期时间:";
    [self addSubview:expireLabel];
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.font = [UIFont fontWithName:@"Gill Sans" size:12];
    [self addSubview:_dateLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.height.mas_equalTo(24);
    }];
    
    [barLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(18);
    }];
    
    [_barcodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(barLabel.mas_right);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.height.mas_equalTo(18);
    }];
    
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(_barcodeLabel.mas_right);
        make.right.equalTo(self.mas_right).offset(-8);
        make.height.mas_equalTo(18);
    }];
    
    [expireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_barcodeLabel.mas_bottom);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.mas_equalTo(56);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(expireLabel.mas_right);
        make.top.equalTo(_barcodeLabel.mas_bottom);
        make.right.equalTo(self.mas_right).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];

}

-(void)updateImage:(UIImage*)image{
    self.imageView.image = image;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
