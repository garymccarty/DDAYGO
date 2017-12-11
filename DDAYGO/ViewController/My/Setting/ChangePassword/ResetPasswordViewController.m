//
//  ResetPasswordViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "PrefixHeader.pch"
@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = NSLocalizedString(@"修改密码", nil);
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.ResetPasswordscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    
}
- (void)initUI {
    self.oldpwTextfield.secureTextEntry = YES;
    self.newpwTextfield.secureTextEntry = YES;
    self.againpwTextfield.secureTextEntry = YES;
    self.oldpwTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.newpwTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.againpwTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
}
- (IBAction)showpwAction:(UIButton *)sender {
    self.oldpwTextfield.secureTextEntry = sender.selected;
    self.newpwTextfield.secureTextEntry = sender.selected;
    self.againpwTextfield.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}
// 键盘弹起
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.oldpwTextfield resignFirstResponder];
    [self.newpwTextfield resignFirstResponder];
    [self.againpwTextfield resignFirstResponder];
}


@end
