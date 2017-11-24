//
//  NestedCollectionViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/10/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "NestedCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_SixthModel.h"
@implementation NestedCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
    //    主图
    UIImageView * imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(1);
        make.top.equalTo(self).offset(-1);
        make.right.equalTo(self).offset(-1);
        make.bottom.equalTo(self).offset(-50);
        make.width.mas_offset(ZP_Width / 3-1);
    }];
    _imageView = imageView;
    
    //    文字介绍
    UILabel * introduceLabel = [UILabel new];
    introduceLabel.textColor = ZP_HomeTitleTypefaceCorlor;
    introduceLabel.textAlignment = NSTextAlignmentCenter;
    introduceLabel.lineBreakMode = UILineBreakModeWordWrap; //文字分行
    introduceLabel.numberOfLines = 0;
    introduceLabel.font = ZP_TrademarkFont;
    [self addSubview:introduceLabel];
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(imageView).offset(10);
    }];
    _introduceLabel = introduceLabel;
    
    //    优惠价格
    UILabel * PreferentialLabel = [UILabel new];
    PreferentialLabel.textColor = ZP_HomePreferentialpriceTypefaceCorlor;
    PreferentialLabel.textAlignment = NSTextAlignmentLeft;
    PreferentialLabel.font = ZP_introduceFont;
    [self addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.bottom.equalTo(introduceLabel).offset(15);
    }];
    _PreferentialLabel = PreferentialLabel;
    
    //    价格
    UILabel * priceLabel = [UILabel new];
    priceLabel.textColor = ZP_HomeTitlepriceTypefaceColor;
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.font = ZP_TrademarkFont;
    [self addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.bottom.equalTo(PreferentialLabel).offset(10);
    }];
    _priceLabel = priceLabel;
    
    //    横线
    UIView * Crossview = [UIView new];
    Crossview.backgroundColor = ZP_HomeTitlepriceTypefaceColor;
    [self addSubview: Crossview];
    [Crossview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.bottom.equalTo(PreferentialLabel).offset(4.5);
        make.width.mas_equalTo(priceLabel);
        make.height.mas_equalTo(1);
    }];
    
    //    商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.contentView addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.bottom.equalTo(priceLabel).offset(10);
        make.width.mas_offset(10);
        make.height.mas_offset(10);
    }];
    _TrademarkImage = TrademarkImage;
    
    //    商标编号
    UILabel * TrademarkLabel = [UILabel new];
    TrademarkLabel.textAlignment = NSTextAlignmentLeft;
    TrademarkLabel.textColor = ZP_HomeTitlepriceTypefaceColor;
    TrademarkLabel.font = ZP_TrademarkFont;
    [self.contentView addSubview:TrademarkLabel];
    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35);
        make.bottom.equalTo(priceLabel).offset(10);
//        make.width.mas_equalTo(ZP_Width / 3 - 1 - 45);
//        make.height.mas_equalTo(20);
    }];
    _TrademarkLabel = TrademarkLabel;
    
    //    分割线
    UIView * view1 = [UIView new];
    view1.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(ZP_Width - 30);
        make.height.mas_equalTo(1);
    }];
    
    //    分割线
    UIView * view2 = [UIView new];
    view2.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(ZP_Width -30);
    }];
    
}

- (void)cellWithdic:(ZP_SixthModel *)model {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    _introduceLabel.text = model.productname;
    _PreferentialLabel.text = [NSString stringWithFormat:@"RMB:%@", model.PreferentialLabel];
    _priceLabel.text = [NSString stringWithFormat:@"RMB:"];
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = model.TrademarkLabel;
    
}

@end
