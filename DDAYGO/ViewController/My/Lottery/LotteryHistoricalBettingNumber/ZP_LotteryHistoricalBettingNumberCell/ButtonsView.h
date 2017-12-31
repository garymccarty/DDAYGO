//
//  ButtonsView.h
//  DDAYGO
//
//  Created by Summer on 2017/12/31.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_LotteryHistoricalBettingNumberModel.h"

@interface ButtonsView : UIView
@property (nonatomic, strong) UIButton * button1;
@property (nonatomic, strong) UIButton * button2;
@property (nonatomic, strong) UIButton * button3;
@property (nonatomic, strong) UIButton * button4;
@property (nonatomic, strong) UIButton * button5;
@property (nonatomic, strong) UIButton * button6;

- (void)viewWithModel:(ZP_LotteryHistoricalBettingNumberModel3 *)model;
@end
