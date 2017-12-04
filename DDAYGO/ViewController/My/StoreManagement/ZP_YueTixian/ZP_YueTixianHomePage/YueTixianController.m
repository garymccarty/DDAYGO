//
//  YueTixianController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/4.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "YueTixianController.h"
#import "PrefixHeader.pch"
@interface YueTixianController ()

@end

@implementation YueTixianController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    
}
- (void)initUI {
     self.title = NSLocalizedString(@"余额", nil);
        
//    _amountText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _payeeText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _CollectingBankText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _PaymentAccountText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _reservedPhoneText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _emailText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    
}
- (IBAction)CompleteButton:(id)sender {
    ZPLog(@"完成");
}
//  键盘弹起
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
@end
