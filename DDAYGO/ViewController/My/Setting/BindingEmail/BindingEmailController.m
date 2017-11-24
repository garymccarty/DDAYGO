//
//  BindingEmailController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/6.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BindingEmailController.h"
#import "PrefixHeader.pch"
#import "PromptBox.h"
#import "TextView.h"
@interface BindingEmailController ()
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextFiled;
@property (weak, nonatomic) IBOutlet TextView * ZPCodeTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet UIButton * BinDing;

@end

@implementation BindingEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = NSLocalizedString(@"绑定", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
}

- (void)initUI {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _BinDing.layer.cornerRadius = 8.0;
    _BinDing.layer.masksToBounds = YES;
    
    [_ZPCodeTextField.functionBtn addTarget:self action:@selector(getMSNCode) forControlEvents:UIControlEventTouchUpInside];
    _ZPCodeTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _ZPPswTextField.showBtn                    = NO;
    _ZPPswTextField.showEyeBtn                 = YES;
    [_ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
}
//  绑定邮箱成功与失败
- (IBAction)BindingEmail:(id)sender {
    [[PromptBox getInstance] showDialogBoxWithOperation:DDABuildingICUC FinishBlock:nil];
    ZPLog(@"----");
}
#pragma mark - - - - - - - - - - - - - - - event response 事件相应 - - - - - - - - - - - - - -
- (void)getMSNCode{
    __weak typeof (self) WeakSelf = self;
    [_ZPCodeTextField.functionBtn startWithTime:60 title:NSLocalizedString(@"重新获取", nil) titleColor:[UIColor whiteColor]countDownTitle:@"s" countDownTitleColor:[UIColor whiteColor] mainColor:ZP_PayColor countColor:ZP_PayColor];
    [WeakSelf qurestCode];  // 开始获取验证码
}
//  发生网络请求 --> 获取验证码
- (void)qurestCode {
    
    ZPLog(@"发生网络请求 --> 获取验证码");
    
}
//  密码显示与隐藏
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
@end
