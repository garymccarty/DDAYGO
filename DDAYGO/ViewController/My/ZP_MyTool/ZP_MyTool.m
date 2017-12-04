//
//  ZP_MyTool.m
//  DDAYGO
//
//  Created by Summer on 2017/10/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
#import "ZP_NetorkingTools.h"
#import "NSString+Additions.h"
@implementation ZP_MyTool
// 个人资料
+ (void)requestSetHomePage:(NSDictionary *)SetHomePage success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@accountinfo?token=%@&nonce=%@",URLAPI,SetHomePage[@"token"],SetHomePage[@"nonce"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 修改资料(暂时只有昵称，性别)
+ (void)requesModifydata:(NSDictionary *)Modifydata uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *nickname = Modifydata[@"nickname"];
    NSString *address = Modifydata[@"address"];
    
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@updateaccountinfo?nickname=%@&realname=%@&sex=%@&birth=%@&phone=%@&address=%@&token=%@",URLAPI,nickname.encodeToPercentEscapeString,Modifydata[@"realname"],Modifydata[@"sex"],Modifydata[@"birth"],Modifydata[@"phone"],address.encodeToPercentEscapeString,Modifydata[@"token"]].encodeToPercentEscapeString parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//  新增地址
+ (void)requesnewAaddress:(NSDictionary *)newAaddress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * str = [NSString stringWithFormat:@"%@addreceipt?name=%@&phone=%@&cell=%@&email=%@&zipcode=%@&address=%@&isdefault=%@&token=%@",URLAPI,newAaddress[@"name"],newAaddress[@"phone"],newAaddress[@"cell"],newAaddress[@"email"],newAaddress[@"zipcode"],newAaddress[@"address"],newAaddress[@"isdefault"],newAaddress[@"token"]];
    NSString * urlString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:urlString parameters:nil success:^(NSDictionary *responseObject) {
        
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  收货地址
+ (void)requesAddress:(NSDictionary *)Address success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@",URLAPI,RequestAddress] parameters:Address success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
        ZPLog(@"%@",error);
    }];
}
//  设定默认地址
+ (void) requestDefaultAddress:(NSDictionary *)DefaultAddress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@setadressdefault?adsid=%@&token=%@",URLAPI,DefaultAddress[@"adsid"],DefaultAddress[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  绑定ICUE
+ (void)requestBindingICUE:(NSDictionary *)Binding success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@updateicueaccount?acc=%@&pwd=%@&token=%@",URLAPI,Binding[@"icueaccount"],Binding[@"pwd"],Binding[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  绑定介绍人
+ (void)requesIntroduce:(NSDictionary *)Introduce success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * str = [NSString stringWithFormat:@"%@checkintroducer?acc=%@&token=%@",URLAPI,Introduce[@"acc"],Introduce[@"token"]];
    NSString * urlString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:urlString parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 获取用户收藏商品列表
+ (void)requestgetcollections:(NSDictionary *)Binding success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@getcollections?screen=%@&token=%@",URLAPI,Binding[@"screen"],Binding[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 获取浏览记录
+ (void)requtsFootprint:(NSDictionary *)Footprint success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@gethistorylist?nonce=%@&token=%@",URLAPI,Footprint[@"nonce"],Footprint[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
//  删除浏览记录
+ (void)requtsDeleFootprint:(NSDictionary *)Footprint success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@deletehistory?historyid=%@&token=%@",URLAPI,Footprint[@"historyid"],Footprint[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  获取生成二维码所需要的商家ID
+ (void)requesQrCode:(NSDictionary *)QrCoed success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getqrcode?token=%@&nonce=%@",URLAPI,QrCoed[@"token"],QrCoed[@"nonce"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end

