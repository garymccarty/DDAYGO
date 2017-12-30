//
//  ZP_HistoryBetCell.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_HistoryBetCell.h"
#import "PrefixHeader.pch"
#import "ZP_HistoryModel.h"
@implementation ZP_HistoryBetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)HistoryBet:(ZP_HistoryModel *)model {
//    ZP_HistoryModel * model = [ZP_HistoryModel mj_objectWithKeyValues:model.pollid];
    [_button1 setTitle:[NSString stringWithFormat:@"%02d",model.white1.intValue] forState:UIControlStateNormal];
    [_button2 setTitle:[NSString stringWithFormat:@"%02d",model.white2.intValue] forState:UIControlStateNormal];
    [_button3 setTitle:[NSString stringWithFormat:@"%02d",model.white3.intValue] forState:UIControlStateNormal];
    [_button4 setTitle:[NSString stringWithFormat:@"%02d",model.white4.intValue] forState:UIControlStateNormal];
    [_button5 setTitle:[NSString stringWithFormat:@"%02d",model.white5.intValue] forState:UIControlStateNormal];
    [_button6 setTitle:[NSString stringWithFormat:@"%02d",model.powerball.intValue] forState:UIControlStateNormal];
}

@end
