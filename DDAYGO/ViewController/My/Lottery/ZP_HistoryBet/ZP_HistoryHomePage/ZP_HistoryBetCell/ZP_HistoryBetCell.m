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
    [_button1 setTitle:[model.white1 stringValue] forState:UIControlStateNormal];
    [_button2 setTitle:[model.white2 stringValue] forState:UIControlStateNormal];
    [_button3 setTitle:[model.white3 stringValue] forState:UIControlStateNormal];
    [_button4 setTitle:[model.white4 stringValue] forState:UIControlStateNormal];
    [_button5 setTitle:[model.white5 stringValue] forState:UIControlStateNormal];
    [_button6 setTitle:[model.powerball stringValue] forState:UIControlStateNormal];
}

@end
