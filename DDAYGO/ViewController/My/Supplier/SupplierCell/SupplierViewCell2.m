//
//  SupplierViewCell2.m
//  DDAYGO
//
//  Created by Summer on 2017/12/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SupplierViewCell2.h"
#import "SupplierView.h"
#import "PrefixHeader.pch"
@implementation SupplierViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (IBAction)SelectBut:(UIButton *)sender {
    SupplierView * position = [[SupplierView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
    if (self.finishBlock) {
        self.finishBlock(position);
        //数据
        //    [position Position:_postionArray];
        //返回
        position.ThirdBlock = ^(NSString *ContStr,NSNumber *code) {
            NSLog(@"c = %@",ContStr);
        };
        //  显示
        [position showInView:self];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"position" object:nil];
}

@end
