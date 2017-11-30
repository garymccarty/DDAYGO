//
//  BetHeaderView.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetHeaderView.h"

@implementation BetHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    return self;
}

- (void)updateViewWithColor:(DDColorBet)colorBet TotalCount:(NSInteger)totalCount SelectedCount:(NSInteger)selectedCount {
    if (colorBet == DDRedBet) {
        self.colorBetLabel.text = @"红球：";
    } else {
        self.colorBetLabel.text = @"白球：";
    }
    
    self.totalCountLabel.text = [NSString stringWithFormat:@"%ld个",totalCount];
    
    self.selectedLabel.text = @"已选";
    
    self.selectedCountLabel.text = @(selectedCount).stringValue;
    
    self.individual.text = @"个";
}

@end
