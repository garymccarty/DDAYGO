//
//  BetTableViewMyCell.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetTableViewMyCell.h"
#import "PrefixHeader.pch"
@implementation BetTableViewMyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _butArray= [NSMutableArray array];

}


- (void)upDataButtonWith:(NSInteger )count
{
    
    [self removeAllSubviews];
    
    NSInteger num = 0;
    for (int i = 0; i < 8; i ++) {
        for (int j = 0; j < 8; j ++){
            if (num > count) {
                return;
            }
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(j * ZP_Width / 8, i * ZP_Width / 8, 40, 40);
            but.titleLabel.font = ZP_TrademarkFont;
            [but setBackgroundImage:[UIImage imageNamed:@"bg_white_ball"] forState:UIControlStateNormal];
     
            [but setBackgroundImage:[UIImage imageNamed:@"bg_white_ball_receive"] forState:UIControlStateSelected];
            but.tag = num;
            [self.butArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"obj =%@",obj);
                if (but.tag == [obj integerValue]) {
                    but.selected = YES;
                }
            }];

            [but setTitle:[NSString stringWithFormat:@"%ld",num] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            but.titleEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
            
            
            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
            num ++;
            [self.contentView addSubview:but];
        }
    }
}

- (void)butClick:(UIButton *)btn {
    if (btn.selected) {
        btn.selected = !btn.selected;
        [self.butArray removeObject:[NSNumber numberWithInteger:btn.tag]];
        [self upDataButtonWith:59];
        
    } else {
        if (self.butArray.count == 5) {
            return;
        }
        btn.selected = !btn.selected;
        [self.butArray addObject:[NSNumber numberWithInteger:btn.tag]];
    }
    if (self.arrayBlock) {
        self.arrayBlock(self.butArray);
    }
}

//- (void)setButArray:(NSMutableArray *)butArray
//{
//    self.butArray = butArray;
//    [self upDataButtonWith:59];
//}


- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.contentView.subviews.count) {
      
        [self.contentView.subviews.lastObject removeFromSuperview];
    }
}


@end
