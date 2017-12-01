//
//  ZP_LotteryCollectionViewCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_LotteryCollectionViewCell.h"

@implementation ZP_LotteryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setValue:(NSInteger)index {
    if (index < 10) {
        [self.countBut setTitle:[@"0" stringByAppendingString:@(index).stringValue] forState:UIControlStateNormal];
    }else {
        
        [self.countBut setTitle:@(index).stringValue forState:UIControlStateNormal];
    }
}
@end
