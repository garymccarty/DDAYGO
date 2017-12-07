
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
#import "ZP_MyTool.h"
#import "PayPassController.h"
#import "PayFailController.h"
#import "OrderViewController.h"
@interface DataViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;
    NSString * _str;
}
@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
        [self setupWebView];
}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[_jump_HeadURL stringByAppendingString:@"?"]]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[_jump_URL dataUsingEncoding:NSUTF8StringEncoding]];
    
    [_webView loadRequest:request];
    ZPLog(@"url : %@",request);
    NSLog(@"oid = %@",_Oid);
    
    [self.view addSubview:_webView];
}

#pragma mark -UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"当前连接--》%@",request.URL.absoluteString);
//用一个字符串来接受  全局的· 后面要用
    _str = request.URL.absoluteString;
//    就在这里··手机只动了一下然后就报404？  就是这里url ·
    
//    [SVProgressHUD showWithStatus:@"正在努力加载ing......请再稍等一下下~"]; // 菊花
    
    return YES;
}

///**清除缓存和cookie*/
//- (void)cleanCacheAndCookie {
//    //清除cookies
//    NSHTTPCookie * cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies]){
//        [storage deleteCookie:cookie];
//    }
//    //清除UIWebView的缓存
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    NSURLCache * cache = [NSURLCache sharedURLCache];
//    [cache removeAllCachedResponses];
//    [cache setDiskCapacity:0];
//    [cache setMemoryCapacity:0];
//}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"finish");
//    这里调用接口·
    [_webView removeFromSuperview];
    if ([_str containsString:@"getpayresult"]) {
        [_webView removeFromSuperview];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"poid"] = self.Oid;
        [ZP_MyTool requesOrdPay:dic uccess:^(id obj) {
            
            if ([obj[@"result"] isEqualToString:@"success"]) {
//                [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"支付成功", nil)];
                PayPassController * Pass = [[PayPassController alloc]init];
                [self.navigationController pushViewController:Pass animated:YES];
            }else
                if ([obj[@"result"]isEqualToString:@"failed"]) {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"支付失败", nil)];
            }else
                if ([obj[@"result"] isEqualToString:@"no_result"]) {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"无付款记录", nil)];
            }else
                if ([obj[@"result"] isEqualToString:@"oid_err"]) {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"订单编号不能为空", nil)];
            }
            
        } failure:^(NSError * error) {
            ZPLog(@"%@",error);
        }];
        [SVProgressHUD dismiss];
    }else{
        //这是不包含 该怎么处理· 返回上一个页面还是提示他再求请求·或者是超  自己做另外的处理就好了··
        // 2 请求失败·webveiw 需不需要移除  。要移除。
      [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"链接错误", nil)];
        
    }
}

//stageuser001/test1234 //28939

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"连接失败%@",error);
    [SVProgressHUD dismiss];
    
}


@end
