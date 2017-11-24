//
//  CPCollectionViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_ClassGoodsModel.h"
@interface CPCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * imageView;  // 主图
@property (nonatomic, strong) UILabel * headerlabel;  // 标题
@property (nonatomic, strong) UILabel * preferentialLabel;  // 优惠价格
@property (nonatomic, strong) UILabel * priceLabel;   // 价格
@property (nonatomic, strong) UILabel * TrademarkLabel;  // 商标编号
@property (nonatomic, strong) UIImageView * TrademarkImage; // 商标图片

- (void)cellWithdic:(ZP_ClassGoodsModel *)dic;

@end
