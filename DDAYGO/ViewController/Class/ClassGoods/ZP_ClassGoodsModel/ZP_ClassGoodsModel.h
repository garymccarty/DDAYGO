//
//  ZP_ClassGoodsModel.h
//  DDAYGO
//
//  Created by Summer on 2017/10/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_ClassGoodsModel : NSObject
@property (nonatomic, strong) NSString * productname; // 标题
@property (nonatomic, strong) NSString * productprice; // 优惠价格
//@property (nonatomic, strong) NSString * productprice; // 价格
@property (nonatomic, strong) NSString * defaultimg; //图片
@property (nonatomic, strong) NSString * TrademarkLabel; // 商标编号
@property (nonatomic, strong) NSString * productremark; // 商品介绍
@property (nonatomic, strong) NSString * produced; // 地区
@property (nonatomic, strong) NSNumber * productid;  // ID

+ (instancetype)gEtCassGoods:(NSDictionary *)Dic;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end
