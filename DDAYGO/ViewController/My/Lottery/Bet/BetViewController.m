//
//  BetViewController.m
//  DDAYGO
//
//  Created by 赵宁 on 2017/11/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetViewController.h"
#import "BetHeaderView.h"
#import "PrefixHeader.pch"
#import "BetTableViewCell.h"

@interface BetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) BetHeaderView *whiteBallHeaderView;
@property (nonatomic ,strong) BetHeaderView *redBallHeaderView;

@end

@implementation BetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"下注";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"BetTableViewCell" bundle:nil] forCellReuseIdentifier:@"BetTableViewCell"];
    
//    self.whiteBallHeaderView = [[NSBundle mainBundle] loadNibNamed:@"BetHeaderView" owner:self options:nil].lastObject;
//    self.redBallHeaderView   = [[NSBundle mainBundle] loadNibNamed:@"BetHeaderView" owner:self options:nil].lastObject;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BetTableViewCell"];
    if (indexPath.row == 0) {
        [cell.betHeaderView updateViewWithColor:DDWriteBet TotalCount:5 SelectedCount:1];
        [cell updateCount:69];
    } else {
        [cell.betHeaderView updateViewWithColor:DDRedBet TotalCount:1 SelectedCount:1];
        [cell updateCount:26];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = 0;
    if (indexPath.row == 0) {
        count = 69;
    } else {
        count = 26;
    }
    if (count % 8 == 0) {
        return count / 8 * [UIScreen mainScreen].bounds.size.width/8 + 40;
    } else {
        return count / 8 * [UIScreen mainScreen].bounds.size.width/8 + 80;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
