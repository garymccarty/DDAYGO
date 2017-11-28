//
//  RegisterController.m
//  DDAYGO
//
//  Created by Login on 2017/10/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "RegisterController.h"
#import "TextView.h"
#import "PrefixHeader.pch"
#import "UINavigationBar+Awesome.h"
#import "ZP_NetorkingTools.h"
#import "ZP_LoginTool.h"
#import "UIButton+countDown.h"
#import "ZP_HomeTool.h"
#import "ZP_PositionModel.h"
@interface RegisterController () <UITextFieldDelegate>{
    UIButton * _chooseCityBtn;
}
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextFiled;
@property (weak, nonatomic) IBOutlet TextView * ZPCodeTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPCountryTextField;
@property (weak, nonatomic) IBOutlet UIButton * RegBtn;
@property (weak, nonatomic) IBOutlet UIButton * agreeBtn;

@property (nonatomic, strong) NSString * codeStr;
@property (nonatomic, strong) NSNumber * CountCode;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = @"注册";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
}

- (void)initUI {
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _RegBtn.layer.cornerRadius = 8.0;
    _RegBtn.layer.masksToBounds = YES;
    
    
    [_ZPCodeTextField.functionBtn addTarget:self action:@selector(getMSNCode) forControlEvents:UIControlEventTouchUpInside];
    _ZPCodeTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    [_ZPCountryTextField.functionBtn setTitle:@"点击选择" forState:UIControlStateNormal];
    [_ZPCountryTextField.functionBtn addTarget:self action:@selector(choseCountry) forControlEvents:UIControlEventTouchUpInside];
    _ZPCountryTextField.textField.delegate = self;
    
    _ZPPswTextField.showBtn                    = NO;
    _ZPPswTextField.showEyeBtn                 = YES;
    [_ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
    
}

//  注册
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
    if (_ZPPswTextField.textField.text.length < 6||_ZPPswTextField.textField.text.length >12) {
        [SVProgressHUD showInfoWithStatus:@"密码位数不能小于6大于12"];
        ZPLog(@"密码不足6位");
        return;
    }
    if (_ZPCountryTextField.textField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"选择国家"];
        ZPLog(@"选择国家");
        return;
    }
    if (!_agreeBtn.selected) {
        [SVProgressHUD showInfoWithStatus:@"同意协议"];
        ZPLog(@"同意协议");
        return;
    }
    [self allData];
}

// 数据
- (void)allData {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"email"] = _ZPEmailTextFiled.textField.text;
    dict[@"pwd"] = [self md5:_ZPPswTextField.textField.text];
    dict[@"vcode"] = _ZPCodeTextField.textField.text;
    dict[@"countrycode"] = _CountCode;
    [ZP_LoginTool requestRegiser:dict success:^(id obj) {
        NSDictionary * dic = obj;
        if (![self validateEmail:_ZPEmailTextFiled.textField.text]) {
            if ([dic[@"result"] isEqualToString:@"success"]) {
                NSLog(@"注册成功");
                [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                if ([dic[@"result"] isEqualToString:@"add_error"]) {
                    [SVProgressHUD showInfoWithStatus:@"添加失败"];
                    [self.navigationController popViewControllerAnimated:YES];
            }else {
                if ([dic[@"result"] isEqualToString:@"email_erro"]) {
                    [SVProgressHUD showInfoWithStatus:@"账号已存在"];
                    [self.navigationController popViewControllerAnimated:YES];
            }else {
                if ([dic[@"result"] isEqualToString:@"vcode_err"]) {
                    [SVProgressHUD showInfoWithStatus:@"验证码不能为空"];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    }
                 }
              }
           }
        }
    } failure:^(NSError *error) {
        
        ZPLog(@"%@",error);
    }];
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

- (void)choseCountry {
    [self PositionallData];
    ZPLog(@"选择国家");
}
//  定位数据
- (void)PositionallData {
    
    [ZP_HomeTool requesPosition:nil success:^(id obj) {
        NSArray * arr = [ZP_PositionModel arrayWithArray:obj];
//        ZPLog(@"%@",obj);
        PositionView * position = [[PositionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
        [position Position:arr];
        position.ThirdBlock = ^(NSString *ContStr,NSNumber *code) {
//            NSLog(@"c = %@ %@",ContStr,code);
            _CountCode = code;
            _ZPCountryTextField.textField.text = ContStr;
        };
        //  显示
        [position showInView:self.navigationController.view];
        
    } failure:^(NSError *error) {
//        ZPLog(@"%@",error);
    }];
}

- (IBAction)agreeClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    ZPLog(@"tong yi ");
    
}

- (IBAction)userServerClick:(id)sender {
    ZPLog(@"用户协议 ");
}
#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
- (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
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

//  键盘弹起
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

//  MD5加密方法
-(NSString *)md5:(NSString *)input {
    const char * cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr),digest); // This is the md5 call
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}


#pragma mark - - - - - - - - - - - - - - delegate 视图委托 - - - - - - - - - - - - - -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (_ZPCountryTextField.textField == textField) {
        [self choseCountry];
        return NO;
    }
    return YES;
}

@end
