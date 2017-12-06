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
#import "ZP_MyTool.h"
@interface YueTixianController ()

@end

@implementation YueTixianController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = NSLocalizedString(@"余额", nil);
    UIBarButtonItem * ExtractBut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_withdrawals_record"] style:UIBarButtonItemStyleDone target:self action:@selector(Extract)];
    ExtractBut.tintColor = ZP_WhiteColor;
    self.navigationItem.rightBarButtonItem = ExtractBut;

}

- (void)Extract {
    ZPLog(@"跳转");
    ZP_ExtractController * Extract = [[ZP_ExtractController alloc]init];
    Extract.supplierId = _SupplierId;
    [self.navigationController pushViewController:Extract animated:YES];
    
}
- (IBAction)CompleteButton:(id)sender {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    //    ec77b922d25bb303f27f63d23de84f73
    dic[@"token"] = @"ec77b922d25bb303f27f63d23de84f73";
    dic[@"sid"] = _SupplierId;
    dic[@"amount"] = _amountText.textField.text;
    dic[@"bankcardname"] = [_payeeText.textField.text stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
    dic[@"bankname"] = [_CollectingBankText.textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    dic[@"bankcardno"] = _PaymentAccountText.textField.text;
    dic[@"phone"] = _reservedPhoneText.textField.text;
    dic[@"email"] = _emailText.textField.text;
  
    [ZP_MyTool requesAddSupplierTakeOut:dic success:^(id obj) {
        NSLog(@"obj %@",obj);
    } failure:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
    ZPLog(@"完成");
}

//  键盘弹起
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
@end

