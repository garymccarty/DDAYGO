//
//  CollectionTableViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//


#import "CollectionTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setModel:(collectionModel *)model {
    
     [_ShopimageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@"bg_footprint_frame"]];
    if ([model.state intValue] == 4) {
        _ShopimageView.alpha = 0.5;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _ShopimageView.frame.size.width, 17)];
        label.center = _ShopimageView.center;
        label.text = NSLocalizedString(@"已失效", nil);
        [label setTextColor:[UIColor whiteColor]];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [_ShopimageView addSubview:label];
    }else{
    [_ShopimageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    }
    _priceLabel.text = [NSString stringWithFormat:@"%@",model.productprice];
//    _CurrencySymbolLabel.text = model.CurrencySymbolLabel;
     NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
   _CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@:",str];
    _Cp.text = [NSString stringWithFormat:@"%@",model.cp];
    _shopTextLabel.text = model.productname;
}

@end

