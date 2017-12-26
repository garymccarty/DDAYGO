//
//  BetSeleTableViewCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/16.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetSeleTableViewCell.h"
#import "PrefixHeader.pch"
@implementation BetSeleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _deleBut.layer.borderWidth = 0.5f;
    _deleBut.layer.borderColor = [[UIColor redColor]CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateCount:(NSArray *)arr {
    NSLog(@"sele - %ld",arr.count);

    [self removeAllSubviews];
    for (int i = 0; i < arr.count; i ++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(i * ZP_Width / 10,5, 25, 25);
        [but setBackgroundImage:[UIImage imageNamed:@"bg_choose_whiteball_pressed"] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"bg_choose_redball"] forState:UIControlStateSelected];
//        btn.OpenAppURL.titleLabel.font    = [UIFont systemFontOfSize: 12];
        but.titleLabel.font = ZP_TrademarkFont;
        if ([arr[i] integerValue] > 99) {
         [but setTitle:[NSString stringWithFormat:@"%ld",[arr[i] integerValue] - 100] forState:UIControlStateNormal];
            but.selected = YES;
        }else{
            [but setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];}
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.titleEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnView addSubview:but];

    }

}


- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.btnView.subviews.count) {
        if ([self.btnView.subviews.lastObject isEqual:_deleBut]) {
            return;
        }
        [self.btnView.subviews.lastObject removeFromSuperview];
    }
}
- (void)butClick:(UIButton *)btn
{
//    btn.selected = !btn.selected;

    
}



@end
