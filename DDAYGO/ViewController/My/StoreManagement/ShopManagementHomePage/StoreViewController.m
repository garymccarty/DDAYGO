//
//  StoreViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "StoreViewController.h"
#import "OrdersViewController.h"
#import "BillViewController.h"
#import "UINavigationBar+Awesome.h"
#import "ReceivingController.h"
#import "PrefixHeader.pch"
#import "YueTixianController.h"
@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"商店管理", nil);

//    _merchantscrollView.bounces = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_PayColor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//  提现
- (IBAction)tixianBut:(id)sender {
    YueTixianController * YueTixian = [[YueTixianController alloc]init];
    [self.navigationController pushViewController:YueTixian animated:YES];
}
//  订单
- (IBAction)orderAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    OrdersViewController *viewController = [[OrdersViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//  账单
- (IBAction)billAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    BillViewController *viewController = [[BillViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//  收款
- (IBAction)receivingAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    ReceivingController * Receiving = [[ReceivingController alloc] init];
    [self.navigationController pushViewController:Receiving animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSLog(@"按钮");
}

@end
