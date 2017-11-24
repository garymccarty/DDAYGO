//
//  LanguageController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/6.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LanguageController.h"
#import "MainViewController.h"
#import "PrefixHeader.pch"
#import "NSBundle+Language.h"
@interface LanguageController ()

@end

@implementation LanguageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Language", nil);
    
}
- (IBAction)zhongwen:(id)sender {
    [self changeLanguageTo:@"zh-Hans"];
}
- (IBAction)yinwen:(id)sender {
    [self changeLanguageTo:@"en"];
   
}
- (IBAction)fantizhongwen:(id)sender {
    [self changeLanguageTo:@"zh-Hant"];
}
- (void)changeLanguageTo:(NSString *)language {
//  设置语言
    [NSBundle setLanguage:language];
    
//  然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"Language"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//  我们要把系统windown的rootViewController替换掉
    MainViewController * tab = [[MainViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
//  跳转到设置页
    tab.selectedIndex = 4;
//    [self.navigationController popViewControllerAnimated:YES];
}
//适当的位置移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
