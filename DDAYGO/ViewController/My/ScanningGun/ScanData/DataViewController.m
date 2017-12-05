//
//  DataViewController.m
//  DDAYGO
//
//  Created by Login on 2017/10/11.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "DataViewController.h"
#import "PayViewController.h"
#import "PrefixHeader.pch"
@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.jump_bar_code) {
        PayViewController * pay = [[PayViewController alloc]init];
        [self.navigationController pushViewController:pay animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
         self.hidesBottomBarWhenPushed = NO;
//        [self setupLabel];
    } else {
        [self setupWebView];
    }

}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.frame = self.view.bounds;
    
    // 1. URL 定位资源,需要资源的地址
    NSString * urlStr = self.jump_URL;
    NSURL * url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求数据
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [webView loadRequest:request];
    [self.view addSubview:webView];
}


@end
