//
//  ZP_ClassViewTool.m
//  DDAYGO
//
//  Created by Summer on 2017/10/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ClassViewTool.h"
#import "ZP_NetorkingTools.h"
#import "PrefixHeader.pch"
@implementation ZP_ClassViewTool

// 获取分类类目，大分类
+ (void)requClassIfication:(NSArray *)dfl success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@", URLAPI, HotAPI] parameters:dfl success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取分类类目，（二级）
+(void)requClassIficationrj:(NSDictionary *)dflrj success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@", URLAPI, AdvertisingAPI] parameters:dflrj success:^(NSDictionary *responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//  商品分类
+ (void)requMerchandise:(NSDictionary *)spfl WithIndex:(NSUInteger)index success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSArray * arr = @[@"default",@"sale",@"price",@"time"];
    //    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"http://www.ddaygo.com/api/Test/ProductFilter?producttypeid=2&sort=%@&seq=desc&word=&countrycode=886&page=1&pagesize=30",arr[index]] parameters:spfl success:^(NSDictionary *responseObject) {
    ////        ZPLog(@"%@",responseObject);
    //        success(responseObject);
    //    } failure:^(NSError *error) {
    //        failure(error);
    ////        ZPLog(@"%@",error);
    //    }];
    
    
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@productfilter?fatherid=%@&sort=%@&seq=%@&word=%@&countrycode=%@&page=%@&pagesize=%@",URLAPI,spfl[@"fatherid"],arr[index],spfl[@"seq"],spfl[@"word"],spfl[@"countrycode"],spfl[@"page"],spfl[@"pagesize"]] parameters:nil success:^(NSDictionary *responseObject) {
        //        ZPLog(@"%@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
        //        ZPLog(@"%@",error);
    }];
}
//  商品详情
+ (void)requDetails:(NSDictionary *)spxq success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@?productid=%@&token=%@", URLAPI,Details,spxq[@"productid"],spxq[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
        //        ZPLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  立即购买
+ (void)requPay:(NSDictionary *)spxq success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@ordersaddinfo", URLAPI] parameters:spxq success:^(NSDictionary *responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  根据颜色尺码ID查询库存
+ (void)requColorOrSize:(NSDictionary *)dic success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getcolornormstockid", URLAPI] parameters:dic success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *加入购物车
 */
+ (void)requAddToCart:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@addcart?amount=%@&stockid=%@&token=%@", URLAPI,dic[@"amount"],dic[@"stockid"],dic[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 * 收藏
 */
+ (void)requshoucang:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure{
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@addcollections?productid=%@&token=%@", URLAPI,dic[@"productid"],dic[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 * 取消收藏
 */
+ (void)requCancelshoucang:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure{
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@deletecollection?productid=%@&token=%@", URLAPI,dic[@"productid"],dic[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)requImage:(NSString *)url success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools GET:url parameters:nil success:^(NSDictionary *responseObject) {
        success([UIImage imageWithData:responseObject]);
    } failure:^(NSError *error) {
        NSDictionary *dic = error;
        failure(error);
    }];
}
@end

