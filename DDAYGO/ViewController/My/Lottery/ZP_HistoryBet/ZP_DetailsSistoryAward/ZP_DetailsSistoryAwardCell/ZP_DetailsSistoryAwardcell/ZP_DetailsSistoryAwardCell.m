//
//  ZP_DetailsSistoryAwardCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_DetailsSistoryAwardCell.h"

@implementation ZP_DetailsSistoryAwardCell

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
