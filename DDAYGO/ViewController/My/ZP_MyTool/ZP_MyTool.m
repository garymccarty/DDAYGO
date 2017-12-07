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
    NSString * nickname = Modifydata[@"nickname"];
    NSString * address = Modifydata[@"address"];
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

// 用户扫码后请求付款链接
+ (void)requesQrCodePay:(NSDictionary *)QrCoed success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getqrcodepaylink?",URLAPI] parameters:QrCoed success:^(NSDictionary *responseObject) {
    //        success(responseObject);
    //    } failure:^(NSError *error) {
    //        failure(error);
    //    }];
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@getqrcodepaylink?amount=%@&countrycode=%@&icuetoken=%@&payway=%@&shopcode=%@&token=%@",URLAPI,QrCoed[@"amount"],QrCoed[@"countrycode"],QrCoed[@"icuetoken"],QrCoed[@"payway"],QrCoed[@"shopcode"],QrCoed[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  获取用户供货商ID
+ (void)requesSupplier:(NSDictionary *)Supplier success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getaccountsupplierid?token=%@&nonce=%@",URLAPI,Supplier[@"token"],Supplier[@"nonce"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取商家余额
+ (void)requesMerchantsBalance:(NSDictionary *)MerchantsBalance success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@getsupplierbalance?token=%@&sid=%@",URLAPI,MerchantsBalance[@"token"],MerchantsBalance[@"sid"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 添加提现申请  addsuppliertakeout
+ (void)requesAddSupplierTakeOut:(NSDictionary *)QrCoed success:(void (^)(id))success failure:(void (^)(NSError *))failure {
//    NSString * str = [NSString stringWithFormat:@"%@addsuppliertakeout?token=%@&sid=%@&amount=%@&bankname=%@&bankcardno=%@&bankcardname=%@&phone=%@&email=%@",URLAPI,QrCoed[@"token"],QrCoed[@"sid"],QrCoed[@"amount"],QrCoed[@"bankname"],QrCoed[@"bankcardno"],QrCoed[@"bankcardname"],QrCoed[@"phone"],QrCoed[@"email"]];
//    NSString * urlString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [ZP_NetorkingTools POST:urlString parameters:nil success:^(NSDictionary *responseObject) {
//        success(responseObject);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
    
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@addsuppliertakeout?token=%@&sid=%@&amount=%@&bankname=%@&bankcardno=%@&bankcardname=%@&phone=%@&email=%@",URLAPI,QrCoed[@"token"],QrCoed[@"sid"],QrCoed[@"amount"],QrCoed[@"bankname"],QrCoed[@"bankcardno"],QrCoed[@"bankcardname"],QrCoed[@"phone"],QrCoed[@"email"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

// 获取用户提现记录列表
+ (void)requesWithdrawalRecord:(NSDictionary *)WithdrawalRecord uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@getsupplieroutlist?token=%@&sid=%@&page=%@",URLAPI,WithdrawalRecord[@"token"],WithdrawalRecord[@"sid"],WithdrawalRecord[@"page"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取订单支付结果
+ (void)requesOrdPay:(NSDictionary *)OrdPay uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getpayresult?poid=%@",@"http://www.ddaygo.com/receive/",OrdPay[@"poid"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
//        http://www.ddaygo.com/receive/getpayresult?poid=DG12345645544
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end

