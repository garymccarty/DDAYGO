//
//  PayViewController.m
//  DDAYGO
//
//  Created by Login on 2017/10/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "PayViewController.h"
#import "PayViewCell.h"
#import "PrefixHeader.pch"
#import "UINavigationBar+Awesome.h"
#import "ZP_MyTool.h"
#import "DataViewController.h"

@interface PayViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSString * money;
}
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = @"付款";
    self.view.backgroundColor = ZP_WhiteColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: ZP_textWite}];
    
}

- (void)btnClick{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = @"ec77b922d25bb303f27f63d23de84f73";
    dic[@"amount"] = money;
    dic[@"shopcode"] = self.Oid;
    dic[@"countrycode"] = @"886";
    dic[@"payway"] = @"allpay_balance";
    dic[@"icuetoken"] = nil;
    [ZP_MyTool requesQrCodePay:dic success:^(id objj) {
        
        NSLog(@"obj = %@",objj);
        
        DataViewController * vc = [[DataViewController alloc]init];
        vc.jump_URL = [NSString stringWithFormat:@"%@?%@",objj[@"uri"],objj[@"para"]];
        [self.navigationController pushViewController:vc animated:YES];
        //_strUrl = [NSString stringWithFormat:@"%@?%@",objj[@"uri"],objj[@"para"]];
        //            NSLog(@"%@-%@",obj[@"shopname"],obj[@"supplirid"]);
        //             获取到这三个参数ddaygo， -->  这个从那里来,用来区分二维码
        //shopname，supplirid
       // [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"PayViewCell" bundle:nil] forCellReuseIdentifier:@"PayViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ZP_WhiteColor;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor orangeColor]];
}

#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PayViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
    cell.PayBlock = ^(NSString * text) {
        money = text;
        [self btnClick];
       
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 350;
}

@end
