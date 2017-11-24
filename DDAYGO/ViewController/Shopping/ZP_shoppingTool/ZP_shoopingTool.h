//
//  ZP_shoopingTool.h
//  DDAYGO
//
//  Created by Summer on 2017/11/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_shoopingTool : NSObject
////  购物车首页
//+ (void)requsetShopping:(NSDictionary *)Shopping success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//  获取地址
+ (void)requGetAddress:(NSDictionary *)Address success:(void (^)(id))success failure:(void (^)(NSError *))failure;
// 获取确认订单信息
+ (void)requesMakeSureOrder:(NSDictionary *)MakeSureOrder success:(void (^)(id))success failure:(void (^)(NSError *))failure;
// 选择支付方式
+ (void)requetMethodpay:(NSDictionary *)Methodpay success:(void (^)(id))success failure:(void (^)(NSError *))failure;
// 添加订单并付款
+ (void)requesAddOrdersPay:(NSDictionary *)AddOrdersPay success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取购物车信息
+ (void)requesshoppingData:(NSString *)token success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

// 添加订单并付款
+ (void)requessaddorderpay:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;
@end

