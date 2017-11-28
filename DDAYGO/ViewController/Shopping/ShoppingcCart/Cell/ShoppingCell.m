//
//  ShoppingCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ShoppingCell.h"
#import "PrefixHeader.pch"
@implementation ShoppingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    static NSString * ShoppingID = @"shoppingCell";
    self = [super initWithStyle:style reuseIdentifier:ShoppingID];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //    商品选择按钮
    UIButton * buttom = [UIButton new];
    [buttom setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [buttom setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    buttom.layer.masksToBounds = YES;
    buttom.layer.cornerRadius = buttom.frame.size.height/2;
    buttom.layer.borderColor = [UIColor clearColor].CGColor;
    buttom.layer.borderWidth = 1;
    [buttom setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    [self.contentView addSubview:buttom];
    [buttom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(45);
        
    }];
    _buttom = buttom;
    
    //  图片
    UIImageView * imageView = [UIImageView new];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5); // 上
        make.left.equalTo(self).offset(30);  // 左
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(120-20);
    }];
    _leftImageView = imageView;
    
    //  商品文字
    ZP_GeneralLabel * titleLabel = [ZP_GeneralLabel initWithtextLabel:_titleLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    titleLabel.lineBreakMode = UILineBreakModeWordWrap; //文字分行
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView).offset(8);
        make.left.equalTo(imageView).offset(85);
        make.right.equalTo(imageView).offset(ZP_Width - 30 -85);
    }];
    _titleLabel = titleLabel;
    
    //  商品颜色
    ZP_GeneralLabel * descLabel = [ZP_GeneralLabel initWithtextLabel:_descLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView).offset(85);
        make.top.equalTo(titleLabel).offset(35);
        make.width.mas_offset(50);
    }];
    _descLabel = descLabel;

//    商品尺码
    ZP_GeneralLabel * SizeLabel = [ZP_GeneralLabel initWithtextLabel:_SizeLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:SizeLabel];
    [SizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(descLabel).offset(45);
        make.top.equalTo(titleLabel).offset(35);
        make.width.mas_offset(25);
    }];
    _SizeLabel = SizeLabel;
    
//  优惠价格
    ZP_GeneralLabel * PreferentialLabel = [ZP_GeneralLabel initWithtextLabel:_PreferentialLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView).offset(85); //左边
        make.top.equalTo(SizeLabel).offset(20); // 下
        make.height.mas_offset(20);
        make.width.mas_offset(100);
    }];
    _PreferentialLabel = PreferentialLabel;
    
//  价格
    ZP_GeneralLabel * PriceLabel = [ZP_GeneralLabel initWithtextLabel:_PriceLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:PriceLabel];
    [PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView).offset(85);
        make.top.equalTo(PreferentialLabel).offset(20);
        make.width.mas_offset(65);
        
    }];
    _PriceLabel = PriceLabel;
    
//  横线
    UIView * backView = [UIView new];
    backView.layer.borderWidth = 1;
    backView.backgroundColor = ZP_TypefaceColor;
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView).offset(85);  // 左
        make.top.equalTo(PreferentialLabel).offset(28);
        make.height.mas_equalTo(1); // 高
        make.width.mas_equalTo(PriceLabel);
    }];
    
    _backView = backView;
    
    //  商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.contentView addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PreferentialLabel).offset(85);
        make.top.equalTo(PreferentialLabel).offset(15);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    _TrademarkImage = TrademarkImage;
    
//  商标编号
    ZP_GeneralLabel * TrademarkLabel = [ZP_GeneralLabel initWithtextLabel:_TrademarkLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:TrademarkLabel];
    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TrademarkImage).offset(18);
        make.top.equalTo(TrademarkImage).offset(0);
    }];
    _TrademarkLabel = TrademarkLabel;
    
//  竖线
    UIView * VerticalView = [UIView new];
    VerticalView.layer.borderWidth = 1;
    VerticalView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.contentView addSubview:VerticalView];
    [VerticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TrademarkLabel).offset(40);
        make.top.equalTo(TrademarkImage).offset(5); // 下
        make.height.mas_equalTo(20); // 高
        make.width.mas_equalTo(1); // 宽
    }];
    
//  符号X
    ZP_GeneralLabel * SharacterLabel = [ZP_GeneralLabel initWithtextLabel:_SharacterLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:SharacterLabel];
    SharacterLabel.text = @"x";
    [SharacterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(VerticalView).offset(3);
        make.top.equalTo(VerticalView).offset(0);
    }];
    _SharacterLabel = SharacterLabel;
    
//  数量
    ZP_GeneralLabel * QuantityLabel = [ZP_GeneralLabel initWithtextLabel:_QuantityLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:QuantityLabel];
    [QuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SharacterLabel).offset(10);
        make.top.equalTo(SharacterLabel).offset(+3.5);
    }];
    _QuantityLabel = QuantityLabel;
    
//  分割线
    UIView * view1 = [UIView new];
    view1.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.right.equalTo(self).offset(ZP_Width - 100); //长
        make.bottom.equalTo(self).offset(0); // 高
        make.height.mas_equalTo(1); // 高
    }];
}

- (void)cellWithModel:(ZP_CartsModel *)model {
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:nil];;
    _titleLabel.text = model.productremark;
    _descLabel.text = model.colorname;
    _SizeLabel.text = model.normname;
    _PreferentialLabel.text = [NSString stringWithFormat:@"RMB:%@",model.priceamount];
    _PriceLabel.text = [NSString stringWithFormat:@"RMB:%@",model.productprice];
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = [NSString stringWithFormat:@"%@",model.cp];
    _QuantityLabel.text = [NSString stringWithFormat:@"%@",model.amount];
}

@end

