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
@interface ForgetPswController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPCodeTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPConPswTextField;
@property (nonatomic, strong) NSString * codeStr;

@end

@implementation ForgetPswController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self touchesBegan];
    [self secureTextEntry];
    _ForgetPswscrollView.bounces = NO;
    [self initUI];
    self.title = @"忘记密码";
}
// UI
- (void)initUI {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.ForgetPswscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    self.ZPEmailTextField.textField.delegate = self;
    self.ZPCodeTextField.textField.delegate = self;
    self.ZPPswTextField.textField.delegate = self;
    self.ZPConPswTextField.textField.delegate = self;
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
        [SVProgressHUD showInfoWithStatus:@"邮箱格式不正确"];
        return;
    }
    __weak typeof (self) WeakSelf = self;
    [self.ZPCodeTextField.functionBtn startWithTime:60 title:NSLocalizedString(@"重新获取", nil) titleColor:[UIColor whiteColor]countDownTitle:@"s" countDownTitleColor:[UIColor whiteColor] mainColor:ZP_PayColor countColor:ZP_PayColor];
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
        [SVProgressHUD showSuccessWithStatus:@"发送成功!"];
        ZPLog(@"发送成功");
        _codeStr = dic[@"code"];
    }else
        if ([dic[@"result"] isEqualToString:@"acc_null_err"]) {
            [SVProgressHUD showInfoWithStatus:@"账号不能为空"];
    }else
        if ([dic[@"result"] isEqualToString:@"acc_email_err"]) {
            [SVProgressHUD showInfoWithStatus:@"賬號不存在"];
    }else
        if ([dic[@"result"] isEqualToString:@"send_error"]) {
            [SVProgressHUD showInfoWithStatus:@"验证码发送失败,请稍后再试"];
        }
        
    } failure:^(NSError * error) {
        ZPLog(@"%@", error);
    }];
}

// 完成按钮
- (IBAction)DetermineBut:(id)sender {
    if (self.ZPPswTextField.textField.text.length < 8 || self.ZPPswTextField.textField.text.length >20) {
        [SVProgressHUD showInfoWithStatus:@"密码位数不能小于8大于20"];
        ZPLog(@"密码不足6位");
        return;
    }
    if (![self judgePassWordLegal:self.ZPConPswTextField.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"密码必须8-20大小写数字组合"];
        ZPLog(@"密码不足8位");
        return;
    }
    if (self.ZPPswTextField.textField.text != self.ZPConPswTextField.textField.text) {
        [SVProgressHUD showInfoWithStatus:@"两次密码不一致"];
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
            [SVProgressHUD showSuccessWithStatus:@"密码找回成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([obj[@"result"] isEqualToString:@"acc_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"账号为空"];
        }else
            if ([obj[@"result"] isEqualToString:@"verifyemail_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"验证邮箱为空"];
        }else
            if ([obj[@"result"] isEqualToString:@"npwd_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"密码为空"];
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

/***********鍵盤************/
-(void)textFieldDidBeginEditing:(UITextField *)textField{// 文本编辑开始时
    [UIView animateWithDuration:0.4 animations:^{
        self.ForgetPswscrollView.contentOffset = CGPointMake(0, ZP_Width - 210);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        self.ForgetPswscrollView.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.ForgetPswscrollView endEditing:YES];
}

//隐藏键盘
- (void)keyboardWillHide:(NSNotification *)notification {
    //将contentInset的值设回原来的默认值
    UIEdgeInsets e = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.ForgetPswscrollView setContentInset:e];
}

// 键盘触摸
- (void)touchesBegan {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
// 触发事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap {
    [_ZPEmailTextField.textField resignFirstResponder];
    [_ZPCodeTextField.textField resignFirstResponder];
    [_ZPPswTextField.textField resignFirstResponder];
    [_ZPConPswTextField.textField resignFirstResponder];
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
