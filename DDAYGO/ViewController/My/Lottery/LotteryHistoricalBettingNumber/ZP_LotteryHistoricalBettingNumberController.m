//
//  ZP_LotteryHistoricalBettingNumberController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_LotteryHistoricalBettingNumberController.h"
#import "ZP_LotteryHistoricalBettingNumberCell.h"
#import "PrefixHeader.pch"
@interface ZP_LotteryHistoricalBettingNumberController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZP_LotteryHistoricalBettingNumberController

- (void)viewDidLoad {
    [self initTableHeadView];
    [super viewDidLoad];
    [self initUI];
}

//  UI
- (void)initUI {
    self.title = NSLocalizedString(@"历史下注号码", nil);
//    static NSString * LotteryID = @"ZP_LotteryHistoricalBettingNumberCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_LotteryHistoricalBettingNumberCell" bundle:nil] forCellReuseIdentifier:@"ZP_LotteryHistoricalBettingNumberCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    /**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}

- (void)initTableHeadView {
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 30)];
    //    self.tableview.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_Graybackground];
    //     标题1
    ZP_GeneralLabel * TitleLabel1 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel1.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    TitleLabel1.text = @"第2017136期";
    [myView addSubview:TitleLabel1];
    _TitleLabel1 = TitleLabel1;
    [TitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(8);
        make.centerY.equalTo(myView);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //     标题2
    ZP_GeneralLabel * TitleLabel2 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel2.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    TitleLabel2.text = @"2017-11-19（周日）";
    [myView addSubview:TitleLabel2];
    _TitleLabel2 = TitleLabel2;
    [TitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(TitleLabel1.mas_trailing);
        make.top.equalTo(TitleLabel1).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    self.tableView.tableHeaderView = myView;
}

//表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, ZP_Width, 20)];
    //    self.tableview.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_WhiteColor];
    //     订单
    ZP_GeneralLabel * OrderLabel = [ZP_GeneralLabel initWithtextLabel:_OrderLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    OrderLabel.text = @"订单号";
    [myView addSubview:OrderLabel];
    _OrderLabel = OrderLabel;
    [OrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(myView).offset(8);
        make.centerY.equalTo(OrderLabel).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //     订单号
    ZP_GeneralLabel * OrderNumberLabel = [ZP_GeneralLabel initWithtextLabel:_OrderNumberLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    OrderNumberLabel.text = @"5678908765456";
    [myView addSubview:OrderNumberLabel];
    _OrderNumberLabel = OrderNumberLabel;
    [OrderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(OrderLabel.mas_trailing).offset(2);
        make.centerY.equalTo(OrderLabel).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    return myView;
}

//// 领奖按钮
//- (void)AwardBut {
//    ZPLog(@"按钮");
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 3;
}

/*设置标题头的宽度*/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

/*设置cell 的宽度 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 35;
    
}

#pragma mark -- tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString * LotteryID = @"ZP_LotteryHistoricalBettingNumberCell";
    ZP_LotteryHistoricalBettingNumberCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_LotteryHistoricalBettingNumberCell"];
    
    return cell;
}

@end
