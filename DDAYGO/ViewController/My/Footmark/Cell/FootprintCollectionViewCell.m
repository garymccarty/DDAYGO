//
//  FootprintCollectionViewCell.m
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FootprintCollectionViewCell.h"
#import "PrefixHeader.pch"
@implementation FootprintCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)FootprintCollection:(ZP_FootprintModel *)model {
    [_defaultimg sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    _productname.text = model.productname;
    _productprice.text = [NSString stringWithFormat:@"%@",model.productprice];
    _cp.text = [NSString stringWithFormat:@"%@",model.cp];
    _CurrencySymbolLabel.text = model.CurrencySymbolLabel;
    
}
@end
