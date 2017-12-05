//
//  ZP_ExtractController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/5.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ExtractController.h"
#import "ZP_ExtractCell.h"
#import "PrefixHeader.pch"
@interface ZP_ExtractController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZP_ExtractController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = NSLocalizedString(@"提现记录", nil);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_ExtractCell" bundle:nil] forCellReuseIdentifier:@"ZP_ExtractCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = ZP_green;
//    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_greenen];
    
}
#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_ExtractCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_ExtractCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 350;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
