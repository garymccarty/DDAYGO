//
//  LotteryController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LotteryController.h"
#import "ZP_LotteryCell/ZP_LotteryViewCell.h"
#import "PrefixHeader.pch"
#import "BetViewController.h"
@interface LotteryController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView * bottomCV;


@end

@implementation LotteryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initUI];
    self.title = NSLocalizedString(@"赏金彩", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
}

- (void)initUI {
    [self.bottomCV registerNib:[UINib nibWithNibName:@"ZP_LotteryViewCell" bundle:nil] forCellReuseIdentifier:@"ZP_LotteryViewCell"];
    for (int i = 0;i <= 1 ; i ++) {
        UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bg_prize_explan"] style:UIBarButtonItemStylePlain target:self action:@selector(Instruction)];
        self.navigationItem.rightBarButtonItem = item;
    }
/**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.bottomCV.estimatedRowHeight = 0;
        self.bottomCV.estimatedSectionHeaderHeight = 0;
        self.bottomCV.estimatedSectionFooterHeight = 0;
    }
    
}

- (void)Instruction {
    BetViewController *viewController = [[BetViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    ZPLog(@"说明");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 2;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZP_LotteryViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_LotteryViewCell"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选中%ld",(long)indexPath.item);
}
@end
