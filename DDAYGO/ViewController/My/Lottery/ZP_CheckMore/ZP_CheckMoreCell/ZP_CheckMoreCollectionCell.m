//
//  ZP_CheckMoreCollectionCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_CheckMoreCollectionCell.h"

@implementation ZP_CheckMoreCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setValue:(NSInteger)index {
    if (index < 10) {
        [self.countBut setTitle:[@"0" stringByAppendingString:@(index).stringValue] forState:UIControlStateNormal];
    }else {
        
        [self.countBut setTitle:@(index).stringValue forState:UIControlStateNormal];
    }
}
@end
