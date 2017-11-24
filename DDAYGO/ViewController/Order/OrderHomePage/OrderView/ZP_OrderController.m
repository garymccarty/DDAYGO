//
//  ZP_OrderController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_OrderController.h"
#import "PrefixHeader.pch"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "UIFont+Extension.h"
#import "ZPSearchBarBUtton.h"
#import "UIImage+Extension.h"
#import "SearchGooodsController.h"
#import "OrderViewCell.h"
#import "ZP_OrderTool.h"
#import "ZP_OrderModel.h"
#import "FSScrollContentView.h"
#import "ConfirmViewController.h"
@interface ZP_OrderController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate> {
    NSArray * dataArray;
    NSArray * _ModeldataArray;
}
@property (nonatomic, strong)UIButton * btn;
@property (nonatomic, strong)UIView * views;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIScrollView * lastView;
@property (nonatomic, strong)UILabel * line;
@property (nonatomic, strong)UITableView * tableview;

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@end

@implementation ZP_OrderController

-(UILabel *)line {
    if (!_line) {
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, ZP_Width / 5, 2)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e74940"];
        [self.topView addSubview:line];
        _line = line;
    }
    return _line;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUI];
    //数据都写在这个页面·刷新什么的都在这个页面写·
}



-(void)addUI{
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width , ZP_height - NavBarHeight - 40)];
    self.tableview.backgroundColor = ZP_Graybackground;
    //    dataArray = @[@{@"ID":@"123456789",@"Date":@"2017-03-27",@"Time":@"10:00:00",@"title":@"Valvola法莫拉天然植物萃取保加利亚玫瑰纯露200ml",@"merchants":@"阿芙专卖店",@"Preferential":@"￥100.00",@"desc":@"250ml升级装",@"price":@"￥80.00",@"Trademark":@"666",@"Quantiy":@"36",@"Amount":@"900",@"Cost":@"300.00"}];
    
    [self.tableview registerClass:[OrderViewCell class] forCellReuseIdentifier:@"orderViewCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = ZP_Graybackground;
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableview];
    
    
}

- (void)getDataWithState{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([_titleStr isEqualToString:@"全部"]) {
        dic[@"sta"] = @"-1";
    }
    if ([_titleStr isEqualToString:@"待付款"]) {
        dic[@"sta"] = @"1";
    }
    if ([_titleStr isEqualToString:@"待发货"]) {
        dic[@"sta"] = @"2";
    }
    if ([_titleStr isEqualToString:@"待收货"]) {
        dic[@"sta"] = @"3";
    }
    if ([_titleStr isEqualToString:@"评价"]) {
        dic[@"sta"] = @"4";
    }
    dic[@"days"] = @"7";
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    dic[@"orderno"] = @"";
    [ZP_OrderTool requestGetorders:dic success:^(id json) {
        
        _ModeldataArray = [OrderModel arrayWithArray:json];
        
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDataWithState];
}


#pragma Mark - <TableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ModeldataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"orderViewCell";
    OrderModel *model = _ModeldataArray[indexPath.row];
    OrdersdetailModel *model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail[0]];
    
    OrderViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableview.tableFooterView = [[UIView alloc]init];
    cell.AppraiseBut.tag = indexPath.row;
    [cell.AppraiseBut removeTarget:self action:@selector(buttonType) forControlEvents:UIControlEventTouchUpInside];
    [cell.OnceagainBut addTarget:self action:@selector(OnceagainBut:) forControlEvents:UIControlEventTouchUpInside];
    cell.OnceagainBut.tag = indexPath.row;
    [cell InformationWithDic:model2 WithModel:model];
    
    cell.finishBlock = ^(id response) {
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:response animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = NO;
    };
    
    cell.appraiseBlock = ^(id response) {
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:response animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = NO;
    };
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//  再次购买
- (void)OnceagainBut:(UIButton *)OnceagainBut {
    NSLog(@"再次购买");
    OrderModel *model = _ModeldataArray[OnceagainBut.tag];
    OrdersdetailModel *model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail[0]];
    ConfirmViewController *confirm = [[ConfirmViewController alloc]init];
    confirm.stockidsString = [NSString stringWithFormat:@"%@_%@",model2.stockid,model2.amount];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:confirm animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
}

@end

