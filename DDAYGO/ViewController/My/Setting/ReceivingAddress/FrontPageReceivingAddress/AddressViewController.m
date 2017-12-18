//
//  AddressViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "AddAddressViewController.h"
#import "EditViewController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray * newsData;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"收货地址", nil);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressTableViewCell"];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"新增地址", nil)  style:UIBarButtonItemStylePlain target:self action:@selector(addAddress)];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self allData];
    
}

- (void)addAddress {
    AddAddressViewController *viewController = [[AddAddressViewController alloc] init];
    viewController.contentDic = @{@"asd":@(YES)};
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    dic[@"aid"] = _oid;
//    ZPLog(@"%@",dic);
    [ZP_MyTool requesAddress:dic success:^(id obj) {
//        if (self.newsData.count < 1) {
//            UIImageView * image = [UIImageView new];
//            image.image = [UIImage imageNamed:@"icon_fail"];
//            [self.view addSubview:image];
//            [image mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.view).offset(ZP_Width / 2 -25);
//                make.top.equalTo(self.view).offset(20);
//                make.width.mas_offset(50);
//                make.height.mas_equalTo(50);
//            }];
//        }
        
        NSArray * arr = obj;
        self.newsData = [ZP_FrontPageReceivingAddressModel arrayWithArray:arr];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

#pragma mark ---tableView delegate
//3.设置cell之间headerview的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.;
}
//4.设置headerview的颜色
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell" forIndexPath:indexPath];
    ZP_FrontPageReceivingAddressModel * model = self.newsData[indexPath.row];
    cell.defBtn.tag = indexPath.row;
    [cell.defBtn addTarget:self action:@selector(seleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell cellWithdic:model];
    cell.finishBlock = ^(id response) {
        EditViewController * viewController = [[EditViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 138;
}

//默认地址
- (void)seleClick:(UIButton *)btn {
    
    if (!btn.selected) {
        btn.selected = !btn.selected;
        if (btn.selected) {
            ZP_FrontPageReceivingAddressModel * model = self.newsData[btn.tag];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"token"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
            dic[@"adsid"] = model.addressid;
            [ZP_MyTool requestDefaultAddress:dic success:^(id obj) {
                ZPLog(@"%@",obj);
                if ([obj[@"result"] isEqualToString:@"ok"]) {
                [SVProgressHUD showSuccessWithStatus:@"设置成功"];
                
                }else {
                    
                ZPLog(@"失败");
                }
                
            } failure:^(NSError *errpr) {
            }];
            
            for (int i = 0; i < self.newsData.count; i ++) {
                AddressTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                if (i == btn.tag) {
                    
                }else{
                    cell.defBtn.selected = NO;}
            }
        }
    }
    
}

@end

