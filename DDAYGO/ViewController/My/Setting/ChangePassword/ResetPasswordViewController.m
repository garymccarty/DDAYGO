//
//  ResetPasswordViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface ResetPasswordViewController ()<UITextFieldDelegate>

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = NSLocalizedString(@"修改密码", nil);
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.ResetPasswordscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    
}
// UI
- (void)initUI {
    self.oldpwTextfield.secureTextEntry = YES;
    self.newpwTextfield.secureTextEntry = YES;
    self.againpwTextfield.secureTextEntry = YES;
    self.oldpwTextfield.delegate = self;
    self.newpwTextfield.delegate = self;
    self.againpwTextfield.delegate = self;
    self.oldpwTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.newpwTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.againpwTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
}

// 确定按钮
- (IBAction)DetermineBut:(id)sender {
    [self allData];
}

// 数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"opwd"] = [self md5:self.oldpwTextfield.text];
    dic[@"npwd"] = [self md5:self.newpwTextfield.text];
    dic[@"npwd"] = [self md5:self.againpwTextfield.text];
    [ZP_MyTool requestRestPassword:dic success:^(id obj) {
//        if ([obj[@"result"] isEqualToString:@"ok"]) {
//
//        }
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

//// 键盘弹起
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    [self.oldpwTextfield resignFirstResponder];
//    [self.newpwTextfield resignFirstResponder];
//    [self.againpwTextfield resignFirstResponder];
//}
/***********鍵盤************/
-(void)textFieldDidBeginEditing:(UITextField *)textField{// 文本编辑开始时
    [UIView animateWithDuration:0.4 animations:^{
        self.ResetPasswordscrollView.contentOffset = CGPointMake(0, ZP_Width - 210);
    }];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        self.ResetPasswordscrollView.contentOffset = CGPointMake(0, 0);
    }];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.ResetPasswordscrollView endEditing:YES];
}

////隐藏键盘
//- (void)keyboardWillHide:(NSNotification *)notification {
//    //将contentInset的值设回原来的默认值
//    UIEdgeInsets e = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.LoginscrollView setContentInset:e];
//
//    NSLog(@"scrollView.height = %f", self.LoginscrollView.contentSize.height);
//}

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
    [self.oldpwTextfield resignFirstResponder];
    [self.oldpwTextfield resignFirstResponder];
    [self.againpwTextfield resignFirstResponder];
}

//显示密码
- (IBAction)showpwAction:(UIButton *)sender {
    self.oldpwTextfield.secureTextEntry = sender.selected;
    self.newpwTextfield.secureTextEntry = sender.selected;
    self.againpwTextfield.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
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
