//
//  ZP_DetailsSistoryAwardController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_DetailsSistoryAwardController.h"
#import "ZP_DetailsSistoryAwardTableViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface ZP_DetailsSistoryAwardController ()<UITableViewDelegate, UITableViewDataSource>
//@property (strong, nonatomic) IBOutlet UITableView * tableView;

//@property (nonatomic, strong) NSArray * titleArray;

@end

@implementation ZP_DetailsSistoryAwardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
}

- (void)initUI {
    self.title = NSLocalizedString(@"第2017135期", nil);
//    self.titleArray = @[@"奖项",@"对中奖号数",@"本期各奖项金额",@"中奖数",@"赏金金额"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    [self.tableview registerNib:[UINib nibWithNibName:@"ZP_DetailsSistoryAwardTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZP_DetailsSistoryAwardTableViewCell"];
//    [self AllData];
}



#pragma mark -- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_DetailsSistoryAwardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_DetailsSistoryAwardTableViewCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZPLog(@"%ld",indexPath.row);
}

@end
