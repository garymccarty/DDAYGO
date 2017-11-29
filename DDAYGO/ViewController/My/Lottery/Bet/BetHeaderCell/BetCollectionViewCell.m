//
//  BetCollectionViewCell.m
//  DDAYGO
//
//  Created by 赵宁 on 2017/11/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetCollectionViewCell.h"

@implementation BetCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setValue:(NSInteger)index {
    if (index < 10) {
        [self.countBtn setTitle:[@"0" stringByAppendingString:@(index).stringValue] forState:UIControlStateNormal];
    } else {
        [self.countBtn setTitle:@(index).stringValue forState:UIControlStateNormal];
    }
}

@end
