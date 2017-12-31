//
//  ForgetPswController.m
//  DDAYGO
//
//  Created by Login on 2017/10/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ForgetPswController.h"
#import "TextView.h"
#import "PrefixHeader.pch"
#import "UINavigationBar+Awesome.h"
#import "ZP_LoginTool.h"
@interface ForgetPswController ()
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPCodeTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPConPswTextField;
@property (nonatomic, strong) NSString * codeStr;

@end

@implementation ForgetPswController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self secureTextEntry];
    _ForgetPswscrollView.bounces = NO;
    [self initUI];
    self.title = @"忘記密碼";
}
// UI
- (void)initUI {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.ForgetPswscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    self.ZPEmailTextField.textField.keyboardType =  UIKeyboardTypeASCIICapable;
    self.ZPCodeTextField.textField.keyboardType =  UIKeyboardTypeNumberPad;
    self.ZPPswTextField.textField.keyboardType = UIKeyboardTypeDefault;
    self.ZPConPswTextField.textField.keyboardType = UIKeyboardTypeDefault;
    [self.ZPCodeTextField.functionBtn addTarget:self action:@selector(getMSNCode) forControlEvents:UIControlEventTouchUpInside];
    self.ZPCodeTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

// 数据（第一步）
// 获取验证码
- (void)getMSNCode {
    NSLog(@"获取验证码");
    if (![self validateEmail:self.ZPEmailTextField.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"郵箱格式不正確"];
        return;
    }
    __weak typeof (self) WeakSelf = self;
    [self.ZPCodeTextField.functionBtn startWithTime:60 title:NSLocalizedString(@"重新獲取", nil) titleColor:[UIColor whiteColor]countDownTitle:@"s" countDownTitleColor:[UIColor whiteColor] mainColor:ZP_PayColor countColor:ZP_PayColor];
    [WeakSelf qurestCode];  // 开始获取验证码
}

//  发生网络请求 --> 获取验证码
- (void)qurestCode {
    ZPLog(@"发生网络请求 --> 获取验证码");
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = self.ZPEmailTextField.textField.text;
    [ZP_LoginTool requestForgetPsw1:dic success:^(id obj) {
        NSDictionary * dic = obj;
        ZPLog(@"%@",dic);
    if ([dic[@"result"] isEqualToString:@"ok"]) {
        [SVProgressHUD showSuccessWithStatus:@"發送成功!"];
        ZPLog(@"发送成功");
        _codeStr = dic[@"code"];
    }else
        if ([dic[@"result"] isEqualToString:@"acc_null_err"]) {
            [SVProgressHUD showInfoWithStatus:@"賬號不能為空"];
    }else
        if ([dic[@"result"] isEqualToString:@"acc_email_err"]) {
            [SVProgressHUD showInfoWithStatus:@"賬號不存在"];
    }else
        if ([dic[@"result"] isEqualToString:@"send_error"]) {
            [SVProgressHUD showInfoWithStatus:@"驗證碼發送失敗,請稍後再試"];
        }
        
    } failure:^(NSError * error) {
        ZPLog(@"%@", error);
    }];
}

// 完成按钮
- (IBAction)DetermineBut:(id)sender {
    if (self.ZPPswTextField.textField.text.length < 8 || self.ZPPswTextField.textField.text.length >20) {
        [SVProgressHUD showInfoWithStatus:@"密碼位數不能少於8-20位"];
        ZPLog(@"密码不足6位");
        return;
    }
    if (![self judgePassWordLegal:self.ZPConPswTextField.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"密碼必須8-20大小寫數字組合"];
        ZPLog(@"密码不足8位");
        return;
    }
    if (self.ZPPswTextField.textField.text != self.ZPConPswTextField.textField.text) {
        [SVProgressHUD showInfoWithStatus:@"兩次密碼不一致"];
    }else {
        [self AllData];
    }
}

// 修改密码数据（第二步）
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = self.ZPEmailTextField.textField.text;
    dic[@"com&verifyemail"] = self.ZPEmailTextField.textField.text;
    dic[@"npwd"] = self.ZPPswTextField.textField.text;
    dic[@"npwd"] = self.ZPConPswTextField.textField.text;
    [ZP_LoginTool requestForgetPsw2:dic success:^(id obj) {
        if ([obj[@"result"] isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"密碼找回成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([obj[@"result"] isEqualToString:@"acc_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"賬號為空"];
        }else
            if ([obj[@"result"] isEqualToString:@"verifyemail_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"驗證郵箱為空"];
        }else
            if ([obj[@"result"] isEqualToString:@"npwd_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"密碼為空"];
        }else
            if ([obj[@"result"] isEqualToString:@"sys_err"]) {
                [SVProgressHUD showInfoWithStatus:@"修改失敗"];
        }
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
- (BOOL)validateEmail:(NSString *)email {
//     邮箱正则式
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)JudgeTheillegalCharacter:(NSString *)content {
//    提示标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    return [emailTest evaluateWithObject:content];
}

- (BOOL)judgePassWordLegal:(NSString *)pass {
    BOOL result ;
// 判断长度大于8位后再接着判断是否同时包含数字和大小写字母
    NSString * regex =@"(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    return result;
}

//  安全输入
-(void)secureTextEntry {
    _ZPPswTextField.textField.secureTextEntry = !_ZPPswTextField.textField.secureTextEntry;
    if (_ZPPswTextField.textField.secureTextEntry) {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_close.png"] forState:UIControlStateNormal];
    }else {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_open.png"] forState:UIControlStateNormal];
    }
}
//  MD5加密方法
-(NSString *)md5:(NSString *)input {
    const char * cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr),digest); // This is the md5 call
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}

@end
