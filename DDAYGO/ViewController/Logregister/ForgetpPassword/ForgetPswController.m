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
@interface ForgetPswController ()
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPCodeTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPConPswTextField;

@end

@implementation ForgetPswController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self touchesBegan]; //触摸事件
    self.title = @"忘记密码";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.ForgetPswscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
}
- (void)initUI {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [_ZPCodeTextField.functionBtn addTarget:self action:@selector(getMSNCode) forControlEvents:UIControlEventTouchUpInside];
    _ZPCodeTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)getMSNCode {
    NSLog(@"获取验证码");
    
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
    [_ZPEmailTextField resignFirstResponder];
    [_ZPCodeTextField resignFirstResponder];
    [_ZPPswTextField resignFirstResponder];
    [_ZPConPswTextField resignFirstResponder];
}

@end
