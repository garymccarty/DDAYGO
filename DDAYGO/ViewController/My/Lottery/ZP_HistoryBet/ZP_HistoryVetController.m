//
//  ZP_HistoryVetController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_HistoryVetController.h"
#import "ZP_HistoryBetCell.h"
#import "PrefixHeader.pch"
@interface ZP_HistoryVetController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZP_HistoryVetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI {
    self.title = NSLocalizedString(@"历史下注", nil);
//    static NSString * ZP_HistoryID = @"ZP_HistoryBetCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_HistoryBetCell" bundle:nil] forCellReuseIdentifier:@"ZP_HistoryBetCell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString * HistoryID = @"ZP_HistoryBetCell";
    ZP_HistoryBetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_HistoryBetCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}
@end
