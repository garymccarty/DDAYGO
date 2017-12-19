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
#import "AppraiseController.h"
@interface ZP_OrderController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate> {
//    int _i;
    NSArray * dataArray;
    NSArray * _ModeldataArray;
}
@property (nonatomic, strong)UIButton * btn;
@property (nonatomic, strong)UIView * views;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIScrollView * lastView;
@property (nonatomic, strong)UILabel * line;
@property (nonatomic, strong)UITableView * tableview;

@property (nonatomic, strong) FSPageContentView * pageContentView;
@property (nonatomic, strong) FSSegmentTitleView * titleView;
//@property (nonatomic, strong) NSMutableArray * newsData;
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
//    [self addRefresh];
    //数据都写在这个页面·刷新什么的都在这个页面写·
}

//- (void)addRefresh {
//    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.newsData removeAllObjects];
//        _i = 0;
//        [self getDataWithState];
//    }];
//    //    进入刷新
//    [self.tableview.mj_header beginRefreshing];
//
//    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
////        [_ModeldataArray reverseObjectEnumerator];
//        _i+=10;
//        [self getDataWithState];
//    }];
//}
-(void)addUI {
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width , ZP_height - NavBarHeight - 40)];
    self.tableview.backgroundColor = ZP_Graybackground;
    [self.tableview registerClass:[OrderViewCell class] forCellReuseIdentifier:@"orderViewCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = ZP_Graybackground;
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableview];
}

- (void)getDataWithState {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
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
        ZPLog(@"%@",json);
        _ModeldataArray = [OrderModel arrayWithArray:json];
        
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (DD_HASLOGIN ) {
      [self getDataWithState];
    }
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
    OrderModel * model = _ModeldataArray[indexPath.row];
//    OrdersdetailModel * model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail[0]];
    
    OrderViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableview.tableFooterView = [[UIView alloc]init];
    cell.AppraiseBut.tag = indexPath.row;
    [cell.AppraiseBut removeTarget:self action:@selector(buttonType) forControlEvents:UIControlEventTouchUpInside];
    [cell.OnceagainBut addTarget:self action:@selector(OnceagainBut:) forControlEvents:UIControlEventTouchUpInside];
    cell.OnceagainBut.tag = indexPath.row;
    OrdersdetailModel * model2;
    if (![_titleStr isEqualToString:@"评价"]) {
         model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail.firstObject];
        
        [cell InformationWithDic:model2 WithModel:model];
    }else {
    [cell InformationWithDic:nil WithModel:model];
    }
    cell.finishBlock = ^(id response) {
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:response animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = NO;
    };
    
//    评论
    cell.appraiseBlock = ^(AppraiseController* response) {
        response.model = model;
        [self.navigationController pushViewController:response animated:YES];
       
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
    OrdersdetailModel * model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail[0]];
    ConfirmViewController *confirm = [[ConfirmViewController alloc]init];
    confirm.stockidsString = [NSString stringWithFormat:@"%@_%@",model2.stockid,model2.amount];
//    self.hidesBottomBarWhenPushed = YES;
    confirm.noEdit = YES;
    confirm.ordersnumber = model.ordersnumber;
    [self.navigationController pushViewController:confirm animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.hidesBottomBarWhenPushed = YES;
}

@end

