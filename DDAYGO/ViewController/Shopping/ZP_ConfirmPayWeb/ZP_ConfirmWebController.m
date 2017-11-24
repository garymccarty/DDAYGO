
//  ZP_ConfirmWebController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ConfirmWebController.h"
#import "PrefixHeader.pch"
@interface ZP_ConfirmWebController ()<UIWebViewDelegate> {
    
    UIWebView * webView;
}

@end

@implementation ZP_ConfirmWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    webView = [UIWebView new];
    [self.view addSubview: webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_UrlStr]]];
}

#pragma mark -UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"当前连接--》%@",request.URL.absoluteString);
    
    [SVProgressHUD showWithStatus:@"正在努力加载ing......请再稍等一下下~"]; // 菊花
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    NSLog(@"连接失败%@",error);
    [SVProgressHUD dismiss];
    
}


@end
