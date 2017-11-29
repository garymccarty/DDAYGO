//
//  LotteryController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LotteryController.h"
#import "ZP_LotteryCell/ZP_LotteryViewCell.h"
#import "PrefixHeader.pch"
@interface LotteryController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView * bottomCV;


@end

@implementation LotteryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initUI];
    self.title = NSLocalizedString(@"赏金彩", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
}

- (void)initUI {
    [self.bottomCV registerNib:[UINib nibWithNibName:@"ZP_LotteryViewCell" bundle:nil] forCellReuseIdentifier:@"ZP_LotteryViewCell"];
    for (int i = 0;i <= 1 ; i ++) {
        UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bg_prize_explan"] style:UIBarButtonItemStylePlain target:self action:@selector(Instruction)];
        self.navigationItem.rightBarButtonItem = item;
    }
/**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.bottomCV.estimatedRowHeight = 0;
        self.bottomCV.estimatedSectionHeaderHeight = 0;
        self.bottomCV.estimatedSectionFooterHeight = 0;
    }
    
}

- (void)Instruction {
    
    ZPLog(@"说明");
}

// 表头
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * myview = [UIView new];
    self.bottomCV.tableHeaderView = myview; // 表头跟着cell一起滚动
    [myview setBackgroundColor:ZP_Graybackground];
    
//    标题
    ZP_GeneralLabel * TitleLabel = [ZP_GeneralLabel initWithtextLabel:_TitleLabel.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    TitleLabel.text = @"中奖号码";
    [myview addSubview:TitleLabel];
    _TitleLabel = TitleLabel;
    [self.TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myview).offset(10);
        make.top.equalTo(myview).offset(10);
    }];
    
//    编号
    ZP_GeneralLabel * NumberingLabel = [ZP_GeneralLabel initWithtextLabel:_NumberingLabel.text textColor:ZP_HomeTitlepriceTypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    NumberingLabel.text = @"第207136期";
    [myview addSubview:NumberingLabel];
    _NumberingLabel = NumberingLabel;
    [self.NumberingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TitleLabel).offset(65);
        make.top.equalTo(TitleLabel).offset(2);
    }];
    
//    日期
    ZP_GeneralLabel * DatesLabel = [ZP_GeneralLabel initWithtextLabel:_DatesLabel.text textColor:ZP_HomeTitlepriceTypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    DatesLabel.text = @"2017-11-19(周日)";
    [myview addSubview:DatesLabel];
    _DatesLabel = DatesLabel;
    [self.DatesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(NumberingLabel).offset(70);
        make.top.equalTo(NumberingLabel).offset(0);
    }];
    
    return myview;
}

//  设置表头高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 50;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 2;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZP_LotteryViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_LotteryViewCell"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选中%ld",(long)indexPath.item);
}
@end
