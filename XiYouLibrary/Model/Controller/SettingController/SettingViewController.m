//
//  SettingViewController.m
//  XiYouLibrary
//
//  Created by 韩钊 on 2017/2/17.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *settingTableView;
@property(nonatomic,strong) NSArray *settingListNames;
//@property(nonatomic,strong) UISwitch *switchButton;

@end


@implementation SettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏的背景色（图片）
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    //设置navigationBar字体及颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self initSettingNames];
    [self initSettingTableView];
}

-(void)initSettingNames{
    _settingListNames = @[@"到期提醒",@"2G/3G/4G下显示图片",@"夜间模式",@"常见问题",@"关于我们"];
}

-(void)initSettingTableView{
    
    _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStyleGrouped];
    _settingTableView.dataSource = self;
    _settingTableView.delegate = self;
    
    [self.view addSubview:_settingTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;  {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_settingListNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    settingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell==nil) {
        cell = [[settingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    [cell initSettingCell];
    cell.label.text = [_settingListNames objectAtIndex:indexPath.row];

    //3个switch按钮
    if (indexPath.row == 0 ) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UISwitch *switchButton_0 = [[UISwitch alloc] init];
        switchButton_0.tag = 0;
        [switchButton_0 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchButton_0];
        
        [switchButton_0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView.mas_top).offset(6);
            make.right.equalTo(cell.contentView.mas_right);
            make.width.equalTo(cell.contentView.mas_width).multipliedBy(0.2);
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-6);
        }];
        
    }
    else if (indexPath.row == 1 ){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UISwitch *switchButton_1 = [[UISwitch alloc] init];
        switchButton_1.tag = 1;
        [switchButton_1 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchButton_1];
        
        [switchButton_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView.mas_top).offset(6);
            make.right.equalTo(cell.contentView.mas_right);
            make.width.equalTo(cell.contentView.mas_width).multipliedBy(0.2);
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-6);
        }];
    }
    else if (indexPath.row == 2 ){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UISwitch *switchButton_2 = [[UISwitch alloc] init];
        switchButton_2.tag = 2;
        [switchButton_2 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchButton_2];
        
        [switchButton_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView.mas_top).offset(6);
            make.right.equalTo(cell.contentView.mas_right);
            make.width.equalTo(cell.contentView.mas_width).multipliedBy(0.2);
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-6);
        }];
    }
    else{
        cell.rightImageView.image = [UIImage imageNamed:@"更多"];
    }

    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SettingNextViewController *settingNextViewController = [[SettingNextViewController alloc] init];
    settingNextViewController.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.row == 3) {
        [self.navigationController pushViewController:settingNextViewController animated:YES];
    }
    else if(indexPath.row == 4){
        [self.navigationController pushViewController:settingNextViewController animated:YES];
    }
    
}



-(void)switchAction:(UISwitch *)sender{
    BOOL isButtonON = [sender isOn];
    if (sender.tag == 0) {
        if (isButtonON) {
            NSLog(@"------我是0号");
        } else {
            NSLog(@"------0号取消");
        }
    }
    else if (sender.tag == 1){
        if (isButtonON) {
            NSLog(@"------我是1号");
        } else {
            NSLog(@"------1号取消");
        }
    }
    else if (sender.tag == 2){
        if (isButtonON) {
            NSLog(@"------我是2号");
        } else {
            NSLog(@"------2号取消");
        }
    }
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
