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
    
}


- (void)updateCount:(NSInteger)count WithIndex:(NSInteger)row {
    self.wirteBetCount = count;
    NSInteger num = 0;
    for (int i = 0; i < 8; i ++) {
        for (int j = 0; j < 8; j ++){
            if (num > count) {
                return;
            }
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(j * ZP_Width / 8, i * ZP_Width / 8, 30, 30);
            [but setBackgroundImage:[UIImage imageNamed:@"bg_choose_whiteball_normal"] forState:UIControlStateNormal];
            if (row == 0) {
                [but setBackgroundImage:[UIImage imageNamed:@"bg_choose_whiteball_pressed"] forState:UIControlStateSelected];
                but.tag = num;
            }else{
                [but setBackgroundImage:[UIImage imageNamed:@"bg_choose_redball"] forState:UIControlStateSelected];
                but.tag = num + 100;
            }
            [but setTitle:[NSString stringWithFormat:@"%ld",num] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            but.titleEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
            
            
            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
            num ++;
            [self.butView addSubview:but];
        }
    }
    [self.contentView rightAnchor];
}

- (void)butClick:(UIButton *)btn {
    NSLog(@"-%ld - %ld",self.but1Array.count,self.but2Array.count);
    if (btn.selected) {
        NSLog(@"go");
        btn.selected = !btn.selected;
        if (btn.tag > 99) {
            [self.but2Array removeObject:[NSNumber numberWithInteger:btn.tag]];
        }else{
            [self.but1Array removeObject:[NSNumber numberWithInteger:btn.tag]];
        }
    } else {
        if (self.but1Array.count == 5) {
            return;
        }
        if (self.but2Array.count == 1) {
            return;
        }
        btn.selected = !btn.selected;
        if (btn.tag > 99) {
            [self.but2Array addObject:[NSNumber numberWithInteger:btn.tag]];
        }else{
            [self.but1Array addObject:[NSNumber numberWithInteger:btn.tag]];
        }
    }
    
    
    
}

- (NSMutableArray *)but1Array {
    if (!_but1Array) {
        _but1Array = [NSMutableArray array];
    }
    return _but1Array;
}

- (NSMutableArray *)but2Array {
    if (!_but2Array) {
        _but2Array = [NSMutableArray array];
    }
    return _but2Array;
}

@end
