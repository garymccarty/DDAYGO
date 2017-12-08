//
//  CPCollectionViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "CPCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_ClassGoodsModel.h"
@implementation CPCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
//    图片
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.frame)- 10, CGRectGetWidth(self.frame)-10)];
    self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.imageView];
    
//    标题
    UILabel * headerlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)- 10, CGRectGetWidth(self.frame)-10, 15)];
    headerlabel.textColor = ZP_TypefaceColor;
    headerlabel.lineBreakMode = NSLineBreakByWordWrapping;
    headerlabel.numberOfLines = 0;
    headerlabel.font = ZP_titleFont;
    headerlabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:headerlabel];
    _headerlabel = headerlabel;
    
//    优惠价格
    UILabel * preferentialLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)+ 10, CGRectGetWidth(self.frame) - 100, 15)];
    preferentialLabel.font = ZP_titleFont;
    preferentialLabel.textColor = ZP_WhiteColor;
    preferentialLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:preferentialLabel];
    _preferentialLabel = preferentialLabel;
    
//    价格
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)+ 30, CGRectGetWidth(self.frame) - 100, 15)];
    priceLabel.textColor = ZP_TypefaceColor;
    priceLabel.font = ZP_TrademarkFont;
    priceLabel.textAlignment = NSTextAlignmentLeft;
//    [self.contentView addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    
//   横线
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)+ 37.5, _priceLabel.height, 1.5)];
    backView.backgroundColor = ZP_TypefaceColor;
//    [self.contentView addSubview:backView];
    
//   商标
    UIImageView * TrademarkImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)- 55, CGRectGetWidth(self.frame)+ 35, 22*0.66, 20-5)];
    
    [self.contentView addSubview:TrademarkImage];
    _TrademarkImage = TrademarkImage;
    
//   商标编号
    UILabel * TrademarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 35, CGRectGetWidth(self.frame)+ 35,CGRectGetWidth(self.frame) - 125 , 15)];
    TrademarkLabel.textAlignment = NSTextAlignmentLeft;
    TrademarkLabel.textColor = ZP_textblack;
    TrademarkLabel.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:TrademarkLabel];
    _TrademarkLabel = TrademarkLabel;
    
}

- (void)cellWithdic:(ZP_ClassGoodsModel *)model {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    _headerlabel.text = model.productname;
    _preferentialLabel.text = model.productprice;
//    _priceLabel.text = model.productprice;
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = model.TrademarkLabel;
    
}

@end
