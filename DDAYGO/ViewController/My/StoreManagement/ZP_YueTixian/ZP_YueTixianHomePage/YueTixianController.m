//
//  YueTixianController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/4.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "YueTixianController.h"
#import "ZP_ExtractController.h"
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
    UIBarButtonItem * ExtractBut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_withdrawals_record"] style:UIBarButtonItemStyleDone target:nil action:@selector(Extract)];
    ExtractBut.tintColor = ZP_WhiteColor;
    self.navigationItem.rightBarButtonItem = ExtractBut;
    
//    _amountText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _payeeText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _CollectingBankText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _PaymentAccountText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _reservedPhoneText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    _emailText.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    
}

- (void)Extract {
    ZPLog(@"跳转");
    ZP_ExtractController * Extract = [[ZP_ExtractController alloc]init];
    [self.navigationController pushViewController:Extract animated:YES];
    
}
- (IBAction)CompleteButton:(id)sender {
    ZPLog(@"完成");
}
//  键盘弹起
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
@end
