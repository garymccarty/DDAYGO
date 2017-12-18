//
//  ZP_QuickLoginController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_QuickLoginController.h"
#import "TextView.h"
#import "PrefixHeader.pch"
#import "ZP_LoginTool.h"
#import "UINavigationBar+Awesome.h"
@interface ZP_QuickLoginController ()

@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet UIButton * LoginBtn;
//@property (nonatomic, strong) UIView * Boview;

@end

@implementation ZP_QuickLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    _LoginBtn.layer.cornerRadius             = 8.0;
    _LoginBtn.layer.masksToBounds            = YES;
    
    _ZPEmailTextField.textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    _ZPPswTextField.showBtn                  = NO;
    _ZPPswTextField.showEyeBtn               = YES;
    [_ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)LoginClick:(id)sender {
    [self AllData];
    ZPLog(@"数据");
}

//  数据
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = _ZPEmailTextField.textField.text;
    dic[@"pwd"] = _ZPPswTextField.textField.text;
    [ZP_LoginTool requsetICUELogin:dic success:^(id obj) {
        NSDictionary * adic = obj;
        ZPLog(@"%@",obj);
        if ([adic[@"result"]isEqualToString:@"no_reg"]) {
            [SVProgressHUD showInfoWithStatus:@"ICUE登录成功，请继续操作"];
        }else {
            if ([adic[@"result"]isEqualToString:@"ok"]) {
                DD_HASLOGIN = YES;
                [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
        }else {
            if ([adic[@"result"]isEqualToString:@"acc_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"账号为空"];
        }else {
            if ([adic[@"result"]isEqualToString:@"pwd_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"密码为空"];
        }else {
            if ([adic[@"result"]isEqualToString:@"sys_err"]) {
                [SVProgressHUD showInfoWithStatus:@"系统错误"];
        }else {
            if ([adic[@"result"]isEqualToString:@"token_err"]) {
                [SVProgressHUD showInfoWithStatus:@"token以存在"];
                            }
                        }
                    }
                }
            }
        }
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
- (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

#pragma mark - 安全输入
-(void)secureTextEntry {
    _ZPPswTextField.textField.secureTextEntry = !_ZPPswTextField.textField.secureTextEntry;
    
    if (_ZPPswTextField.textField.secureTextEntry) {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_close.png"] forState:UIControlStateNormal];
    }else {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_open.png"] forState:UIControlStateNormal];
    }
}

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
    [_ZPEmailTextField resignFirstResponder];
    [_ZPPswTextField resignFirstResponder];
}

//  MD5加密方法
-(NSString *)md5:(NSString *)input {
    const char * cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    //    CC_MD5(cStr, strlen(cStr),digest); // This is the md5 call
    CC_MD5(cStr, (CC_LONG)strlen(cStr),digest); // This is the md5 call
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}


@end
