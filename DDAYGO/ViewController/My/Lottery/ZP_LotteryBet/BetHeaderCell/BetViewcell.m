//
//  BetViewcell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/16.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetViewcell.h"
#import "PrefixHeader.pch"
@implementation BetViewcell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.wirteBetCount = 69;
    self.redBetCount = 26;
    NSInteger num = 0;
    for (int i = 0; i <= 8; i ++) {
        for (int j = 0; j <= 8; j ++) {
            UIButton * but = [[UIButton alloc]initWithFrame:CGRectMake(i * ZP_Width / 8, j * ZP_Width / 8, 30, 30)];
            but.tag = num;
            [but setImage:[UIImage imageNamed:@"bg_choose_whiteball_normal"] forState:UIControlStateNormal];
            but.titleEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
            num ++;
            [self.butView addSubview:but];
        }
    }
}
- (void)updateCount:(NSInteger)count {
    self.wirteBetCount = count;
    [self.contentView rightAnchor];
}
@end
