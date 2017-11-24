//
//  ZP_ExpressDeliveryModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_ExpressDeliveryModel : NSObject
@property (nonatomic, strong) NSString * freightamount; // 快递费

+ (instancetype)GetExpressDeliveryData:(NSDictionary *)dic;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end
