//
//  ZP_LoginTool.m
//  DDAYGO
//
//  Created by Summer on 2017/10/26.
//  Copyright © 2017年 Summer. All rights reserved.
//


#import "ZP_LoginTool.h"
#import "PrefixHeader.pch"
#import "ZP_NetorkingTools.h"
@implementation ZP_LoginTool
//  注册
+ (void)requestRegiser:(NSDictionary *)Regiser success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    //get 请求 格式
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"http://www.ddaygo.com/api/Test/Register?email=%@&pwd=%@&vcode=%@&countrycode=%@",Regiser[@"email"],Regiser[@"pwd"],Regiser[@"vcode"],Regiser[@"countrycode"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
    
    /* ---- 这才是post 请求%@
     [ZP_NetorkingTools POST:@"www.ddaygo.com/api/Test/Register?" parameters:sd success:^(NSDictionary *responseObject) {
     success(responseObject);
     NSLog(@"%@",responseObject);
     } failure:^(NSError *error) {
     failure(error);
     }];
     */
}


//  登录
+ (void)requestLogin:(NSDictionary *)Login success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"http://www.ddaygo.com/api/Test/Login?email=%@&pwd=%@&countrycode=%@",Login[@"email"],Login[@"pwd"],Login[@"countrycode"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    //    [ZP_NetorkingTools POST:@"http://www.ddaygo.com/api/Test/Login?" parameters:Login success:^(NSDictionary *responseObject) {
    //        success(responseObject);
    //        NSLog(@"%@",responseObject);
    //    } failure:^(NSError *error) {
    //        failure(error);
    //    }];
}
// 验证码
+ (void)requestVerificationcode:(NSDictionary *)Yzm success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"http://www.ddaygo.com/api/Test/sendvercode?email=%@",Yzm[@"email"]] parameters:nil success:^(NSDictionary *responseObject) {
        
        success(responseObject);
        
        ZPLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        
        ZPLog(@"%@",error);
        
    }];
}
// 选择地区
+(void)requsetArea:(NSDictionary *)Area success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@",URLAPI, AreaAPI] parameters:Area success:^(NSDictionary *responseObject) {
        success(responseObject);
        ZPLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
