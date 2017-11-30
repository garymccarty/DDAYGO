//
//  LotteryController.h
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 prize
 The winning number
 The sum of the awards in the current period
 Number of winners
 Bounty
 */
@interface LotteryController : UIViewController 
@property (nonatomic, strong) UILabel * TitleLabel;  //标题
@property (nonatomic, strong) UILabel * NumberingLabel; // 编号
@property (nonatomic, strong) UILabel * DatesLabel; // 日期
@property (weak, nonatomic) IBOutlet UIScrollView *zhongjiangScrollView;    //中间滚动图
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *winningNumbLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPeriodLabel;
@property (weak, nonatomic) IBOutlet UILabel *winnersNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *bountyLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *prizeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *winningNumbWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentPeriodWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *winnersNumWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bountyWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *onScrollViewWidth;


@end
