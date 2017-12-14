//
//  LotteryController.h
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LotteryController : UIViewController 
//@property (nonatomic, strong) UILabel * TitleLabel;  //标题
//@property (nonatomic, strong) UILabel * NumberingLabel; // 编号
//@property (nonatomic, strong) UILabel * DatesLabel; // 日期
@property (weak, nonatomic) IBOutlet UIScrollView * zhongjiangScrollView;    //中间滚动图

//奖项
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel1;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel2;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel3;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel4;

//对中奖号数
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel1;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel2;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel3;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel4;

//奖项金额
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel1;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel2;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel3;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel4;

//中奖数
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel1;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel2;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel3;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel4;

//赏金金额
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel1;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel2;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel3;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel4;
//
@property (weak, nonatomic) IBOutlet UIView *bounctyView;
// 订单号码
@property (weak, nonatomic) IBOutlet UILabel *OrderNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *periodsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;



@end
