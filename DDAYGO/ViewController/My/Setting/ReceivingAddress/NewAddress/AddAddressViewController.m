//
//  AddAddressViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "AddAddressViewController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface AddAddressViewController ()
@property (strong, nonatomic) IBOutlet UIButton * acquiescence;

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ContactnumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _ZipcodeaddressTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self touchesBegan]; //触摸事件
}

- (void)setContentDic:(NSDictionary *)contentDic {
    if (contentDic) {
        self.title = NSLocalizedString(@"新增地址", nil);
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress)];
        self.navigationItem.rightBarButtonItem = item;
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
        self.AddAddressScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    }
}
//  保存按钮
- (void)saveAddress {
    [self allData];
    
}

//  数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"adsid"] = @"0";
    dic[@"name"] = _ContactpersonTextField.text;
    dic[@"phone"] = _ContactnumberTextField.text;
    dic[@"cell"] = @"";
    dic[@"email"] = @"";
    dic[@"zipcode"] = _ZipcodeaddressTextField.text;
    dic[@"address"] = _ReceivingaddressTextField.text;
    dic[@"isdefault"] = [NSNumber numberWithBool: _acquiescence.selected];
    dic[@"token"] = Token;
    ZPLog(@"%@",dic);
    
    [ZP_MyTool requesnewAaddress:dic success:^(id obj) {
        NSDictionary * dic = obj;
        
        ZPLog(@"%@",obj);
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            ZPLog(@"加入成功");
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            if ([dic[@"result"] isEqualToString:@"add_up_to_ten"]) {
                [SVProgressHUD showInfoWithStatus:@"添加失败，最多只能添加10条哟"];
        }else {
            if ([dic[@"result"] isEqualToString:@"sys_err"]) {
                [SVProgressHUD showInfoWithStatus:@"服务器连接至火星"];
        }else {
            if ([dic[@"result"] isEqualToString:@"name_err"]) {
                [SVProgressHUD showInfoWithStatus:@"姓名不能为空"];
        }else {
            if ([dic[@"result"] isEqualToString:@"phone_err"]) {
                [SVProgressHUD showInfoWithStatus:@"电话号码不能为空"];
        }else {
            if ([dic[@"result"] isEqualToString:@"address_err"]) {
                [SVProgressHUD showInfoWithStatus:@"地址不能为空"];
            }
                
            
                    }
                }
            }
        }
    }
    } failure:^(NSError * error) {
//        ZPLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
    }];
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
    [_ContactpersonTextField resignFirstResponder];
    [_ContactnumberTextField resignFirstResponder];
//    [_ReceivingareaTextField resignFirstResponder];
    [_ReceivingaddressTextField resignFirstResponder];
    [_ZipcodeaddressTextField resignFirstResponder];
}

// 设置默认地址
- (IBAction)acquiescence:(UIButton *)sender {
    
    sender.selected = !sender.selected;
}

@end



