//
//  BindingIntroduce.m
//  DDAYGO
//
//  Created by Summer on 2017/11/27.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BindingIntroduce.h"
#import "PromptBox.h"
#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
@interface BindingIntroduce ()<UITextFieldDelegate>

@end

@implementation BindingIntroduce

- (void)viewDidLoad {
    [super viewDidLoad];
    [self touchesBegan];
    self.title = NSLocalizedString(@"绑定推荐人", nil);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    _BindingIntroduceTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _BindingIntroduceTextField.delegate = self;
     _BindingIntroduceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.BindingIntroducscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    
}

// 绑定推荐人
- (IBAction)BindingIntroduceTextField:(id)sender {
    [self allData];
//    [[PromptBox getInstance] showDialogBoxWithOperation:DDABuildingICUC FinishBlock:nil];
}
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = _BindingIntroduceTextField.text;
    dic[@"token"] = Token;
    [ZP_MyTool requesIntroduce:dic success:^(id obj) {
        NSDictionary * dic = obj;
        if ([dic[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            if ([dic[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"绑定失败"];
        }else {
            if ([dic[@"result"]isEqualToString:@"no"]) {
                [SVProgressHUD showInfoWithStatus:@"账户不存在"];
        }else {
             if ([dic[@"result"]isEqualToString:@"abnormal_message"]) {
                [SVProgressHUD showInfoWithStatus:@"异常讯息"];
                 
                    }
                }
            }
        }
    } failure:^(NSError * error) {
        
    }];
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
    [_BindingIntroduceTextField resignFirstResponder];
}

@end
