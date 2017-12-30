//
//  Supplier1ViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "Supplier1ViewController.h"
#import "PrefixHeader.pch"
#import "SupplierTableViewCell.h"
#import "SupplierViewCell2.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
#import "SupplierView.h"
@interface Supplier1ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)NSArray * array;
@property (nonatomic, strong)NSArray * postionArray;

@end

@implementation Supplier1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

// UI
-(void)initUI {
    self.title = NSLocalizedString(@"供货商", nil);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
    static NSString * SupplierID = @"SupplierTableViewCell";
    [self.tableView registerNib:[UINib nibWithNibName:SupplierID bundle:nil] forCellReuseIdentifier:SupplierID];
    [self.tableView registerNib:[UINib nibWithNibName:@"SupplierViewCell2" bundle:nil] forCellReuseIdentifier:@"SupplierViewCell2"];
     _array = [NSArray arrayWithObjects:@"公司名稱:",@"統一編號:",@"公司人數:",@"註冊資本:",@"創立日期:",@"組織形態:",@"公司地址:",@"公司電話:",@"公司傳真(選填):",@"公司網址(選填):",@"聯繫人:",@"聯繫電話:",@"經營項目:",@"合作項目:", nil];
}
// 提交按钮
- (IBAction)SubmitBut:(id)sender {
    [self AllData];
}

// 数据
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"companyname"] = @"测试测试";
    dic[@"companycode"] = @"51155455454";
    dic[@"poeplecount"] = @"100人";
    dic[@"capital"] = @"100万";
    dic[@"companydate"] = @"2017-10-11";
    dic[@"companytype"] = @"1";
    dic[@"address"] = @"公司地址公司地址公司地址公司地址";
    dic[@"phone"] = @"141414414441441";
    dic[@"fax"] = @"4545554545";
    dic[@"companyuri"] = @"www.iii.com";
    dic[@"contact"] = @"张鹏";
    dic[@"contactphone"] = @"16161661616";
    dic[@"contactemail"] = @"110@qq.com";
    dic[@"companyproduct"] = @"你好吗";
    dic[@"projectinfo"] = @"你好你好";
    [ZP_MyTool requestSupplierRequest:dic success:^(id obj) {
        ZPLog(@"%@",obj);
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * SupplierID = @"SupplierTableViewCell";
    SupplierTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SupplierID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
    cell.textField.placeholder = nil;
    if (2 == indexPath.row) {
        cell.textField.placeholder = NSLocalizedString(@"如:50 - 100 人", nil);
    }
    if (4 == indexPath.row) {
        cell.textField.placeholder = NSLocalizedString(@"yyyy-MM-dd", nil);
    }
    if (5 == indexPath.row) {
        SupplierViewCell2 * cell2 = [tableView dequeueReusableCellWithIdentifier:@"SupplierViewCell2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
        cell2.TissueMorphologyLabel.text = @"请选择组织形态";
        cell2.finishBlock = ^(id response) {
            [self SupplierllData];
            NSLog(@"位置");
            PositionView * position = [[PositionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
            //数据
            [position Position:_postionArray];
            //返回
            position.ThirdBlock = ^(NSString *ContStr,NSNumber *code) {
                NSLog(@"c = %@",ContStr);
            };
            //  显示
            [position showInView:self.navigationController.view];
        };
        return cell2;
    }
    if (10 == indexPath.row) {
        cell.textField.placeholder = NSLocalizedString(@"聯繫人/職稱/分機", nil);
    }
    cell.titleLabel.text = self.array[indexPath.row];
    return cell;
}

// 获取组织形态列表
- (void)SupplierllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"countrycode"] = @"886";
    [ZP_MyTool requestCompanyType:dic success:^(id obj) {
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    SupplierView * position = [[SupplierView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
    [self SupplierllData];
    //数据
//    [position Position:_postionArray];
    //返回
    position.ThirdBlock = ^(NSString *ContStr,NSNumber *code) {
        NSLog(@"c = %@",ContStr);
        //            [indexPath setTitle:NSLocalizedString(ContStr, nil) forState:UIControlStateNormal];
    };
    //  显示
    [position showInView:self.navigationController.view];
    ZPLog(@"%ld",(long)indexPath.row);
}

@end
