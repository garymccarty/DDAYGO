//
//  ZP_LotteryViewCell.m
//  DDAYGO
//
//  Created by Summer on 2017/11/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_LotteryViewCell.h"
#import "PrefixHeader.pch"


@implementation ZP_LotteryViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

- (void)initUI {
    NSInteger num = 0;
    for (int z = 0; z <= 5; z ++) {
        
        UIButton * butt = [[UIButton alloc]initWithFrame:CGRectMake(z * ZP_Width / 6 , 1, 30, 30)];
        butt.backgroundColor = [UIColor yellowColor];
        butt.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        [self.contentView addSubview:butt];
        num++;
    }
}
@end
