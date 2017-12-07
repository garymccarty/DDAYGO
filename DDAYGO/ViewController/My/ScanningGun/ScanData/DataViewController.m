
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
    
        
        [self setupWebView];

}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.frame = self.view.bounds;
    NSMutableURLRequest * reuqestShare = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:_jump_URL]];
    [reuqestShare setHTTPMethod:@"POST"];
    [webView loadRequest:reuqestShare];
    [self.view addSubview:webView];
}


@end
