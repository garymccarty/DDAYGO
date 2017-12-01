//
//  ZP_DetailsSistoryAwardController.h
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZP_DetailsSistoryAwardController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView * zhongjangScrollView; // 中间滚动图
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel;   // 奖项
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel;  // 对中奖号数
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * prizeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * winningNumbWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * currentPeriodWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * winnersNumWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * bountyWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * onScrollViewWidth;
@end
