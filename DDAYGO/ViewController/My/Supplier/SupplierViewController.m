//
//  SupplierViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SupplierViewController.h"
#import "SupplierTableViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface SupplierViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *noStoreView;

@end

@implementation SupplierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self alldata];
}

- (void)initUI {
    self.title = NSLocalizedString(@"供货商", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
    [self.tableview registerNib:[UINib nibWithNibName:@"SupplierTableViewCell" bundle:nil] forCellReuseIdentifier:@"SupplierTableViewCell"];
}

- (void)alldata {
    DD_CHECK_HASLONGIN;
    [ZP_MyTool requestUserBusinessStatus:DD_TOKEN success:^(id obj) {
        NSDictionary *dic = obj;
        if ([dic[@"resault"] isEqualToString:@"token_err"]) {
            [SVProgressHUD showErrorWithStatus:@"token错误"];
        } else if ([dic[@"resault"] isEqualToString:@"isagent"]) {
            [SVProgressHUD showErrorWithStatus:@"账号是代理商不可申请供货商"];
        } else if ([dic[@"resault"] isEqualToString:@"ok"]) {
            
        }
        NSLog(@"%@",obj);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark --delegate
// 表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * vview = [UIView new];
    vview.backgroundColor = ZP_Graybackground;
    [self.view addSubview:vview];
    [vview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.width.mas_offset(40);
    }];
    return vview;
}
// 设置表头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SupplierTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SupplierTableViewCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
@end
