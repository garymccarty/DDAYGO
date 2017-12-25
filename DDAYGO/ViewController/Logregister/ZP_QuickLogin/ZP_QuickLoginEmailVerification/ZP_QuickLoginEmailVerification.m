//
//  ZP_QuickLoginEmailVerification.m
//  DDAYGO
//
//  Created by Summer on 2017/12/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_QuickLoginEmailVerification.h"
#import "PrefixHeader.pch"
#import "ZP_LoginTool.h"
@interface ZP_QuickLoginEmailVerification ()
@property (nonatomic, strong) NSString * codeStr;
@end

@implementation ZP_QuickLoginEmailVerification

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
// UI
- (void)initUI {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}]; // 更改导航栏字体颜色
    self.EmailVerificationscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;  // 滚动时隐藏键盘
    _RegBut.layer.cornerRadius = 8.0;
    _RegBut.layer.masksToBounds = YES;
    [_ZPCodeTextField.functionBtn addTarget:self action:@selector(getMSNCode) forControlEvents:UIControlEventTouchUpInside];
    
}

- (IBAction)rEgBut:(id)sender {
    if (![self validateEmail:_ZPEmailTextFiled.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"邮箱格式不正确"];
        return;
    }
    if (_ZPCodeTextField.textField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"验证码不能为空"];
        ZPLog(@"请输入验证码");
        return;
    }
    if (![_ZPCodeTextField.textField.text isEqualToString:_codeStr]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确验证码"];
        NSLog(@"请输入正确验证码");
        return;
    }
    
    
}

#pragma mark - - - - - - - - - - - - - - - event response 事件相应 - - - - - - - - - - - - - -
- (void)getMSNCode{
    if (![self validateEmail:_ZPEmailTextFiled.textField.text]) {
        
        [SVProgressHUD showInfoWithStatus:@"邮箱格式不正确"];
        return;
    }
    
    __weak typeof (self) WeakSelf = self;
    [_ZPCodeTextField.functionBtn startWithTime:60 title:NSLocalizedString(@"重新获取", nil) titleColor:[UIColor whiteColor]countDownTitle:@"s" countDownTitleColor:[UIColor whiteColor] mainColor:ZP_PayColor countColor:ZP_PayColor];
    [WeakSelf qurestCode];  // 开始获取验证码
}
//  发生网络请求 --> 获取验证码
- (void)qurestCode {
    ZPLog(@"发生网络请求 --> 获取验证码");
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"email"] = _ZPEmailTextFiled.textField.text;
    
    [ZP_LoginTool requestVerificationcode:dict success:^(id obj) {
        NSDictionary * dic = obj;
        ZPLog(@"%@",dic);
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"发送成功!"];
            ZPLog(@"发送成功");
            _codeStr = dic[@"code"];
        }else {
            if ([dic[@"result"] isEqualToString:@"email_err"]) {
                [SVProgressHUD showInfoWithStatus:@"邮箱已存在"];
            }else {
                if ([dic[@"result"] isEqualToString:@"Error"]) {
                    [SVProgressHUD showInfoWithStatus:@"已连接至火星"];
                    
                }
            }
        }
    } failure:^(NSError * error) {
        ZPLog(@"%@", error);
    }];
}

#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
- (BOOL)validateEmail:(NSString *)email {
    //     邮箱正则式
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//  键盘弹起
//  键盘触摸
- (void)touchesBegan {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //  设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //  将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
// 触发事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_ZPEmailTextFiled resignFirstResponder];
    [_ZPCodeTextField resignFirstResponder];
}

//#pragma mark - - - - - - - - - - - - - - delegate 视图委托 - - - - - - - - - - - - - -
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//
//    if (_ZPCodeTextField.textField == textField) {
//        [self choseCountry];
//        return NO;
//    }
//    return YES;
//}

@end
