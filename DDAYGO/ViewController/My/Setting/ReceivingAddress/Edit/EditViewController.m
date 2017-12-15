//
//  EditViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "EditViewController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface EditViewController ()
@property (strong, nonatomic) IBOutlet UIButton * acquiescence;
@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self touchesBegan];
    self.title = @"编辑地址";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"保存", nil)  style:UIBarButtonItemStylePlain target:self action:@selector(EditAddress)];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}
// 保存点击事件
- (void)EditAddress {
    
    NSLog(@"保存");
    [self allData];
}
//  数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"adsid"] = @"1";
    dic[@"name"] = _ContactpersonTextField.text;
    dic[@"phone"] = _ContactnumberTextField.text;
    dic[@"cell"] = @"123456789";
    dic[@"zipcode"] = _ZipcodeaddressTextField.text;
    dic[@"address"] = _ReceivingaddressTextField.text;
    dic[@"isdefault"] = [NSNumber numberWithBool: _acquiescence.selected];
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
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
                [SVProgressHUD showInfoWithStatus:@"添加失败，最多只能添加10天哟"];
            }else {
                if ([dic[@"result"] isEqualToString:@"sys_err"]) {
                    [SVProgressHUD showInfoWithStatus:@"服务器连接至火星"];
                }
            }
        }
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
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
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
        [_ContactpersonTextField resignFirstResponder];
        [_ContactnumberTextField resignFirstResponder];
        [_ReceivingareaTextField resignFirstResponder];
        [_ReceivingaddressTextField resignFirstResponder];
        [_ZipcodeaddressTextField resignFirstResponder];
}

@end
