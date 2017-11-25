//
//  ZP_FootprintModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_FootprintModel : NSObject
@property (strong, nonatomic) NSString * defaultimg; // 图片
@property (strong, nonatomic) NSString * productname;  // 标题
@property (strong, nonatomic) NSString *productprice; // 商品价格
@property (strong, nonatomic) NSString * cp; // 商品cp
@property (nonatomic, strong) NSNumber *historyid;

+ (instancetype)gEtFootprint:(NSDictionary *)Dic;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end
