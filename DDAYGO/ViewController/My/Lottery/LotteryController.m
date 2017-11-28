//
//  LotteryController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LotteryController.h"
#import "PrefixHeader.pch"
@interface LotteryController ()

@end

@implementation LotteryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"彩票", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
}

@end
