//
//  ZP_ClassGoodsModel.m
//  DDAYGO
//
//  Created by Summer on 2017/10/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ClassGoodsModel.h"

@implementation ZP_ClassGoodsModel

+ (instancetype)gEtCassGoods:(NSDictionary *)Dic {
    return [[self alloc]ininWithClassGoodsData:Dic];
}

- (instancetype)ininWithClassGoodsData:(NSDictionary *)dic {
    if (self == [super init]) {
        self.productname = dic[@"productname"];
        self.productcost = [NSString stringWithFormat:@"%@RMB:",dic[@"productcost"]];
        self.defaultimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@", dic[@"defaultimg"]];
        self.TrademarkLabel = [NSString stringWithFormat:@"%@", dic[@"cp"]];
        self.productid = dic[@"productid"];
        
    }
    return self;
}

+ (id)cheakNull:(id)dic {
    if ([dic isEqual:[NSNull null]]) {
        return @"";
    }
    return dic;
}

+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        ZP_ClassGoodsModel * model = [[ZP_ClassGoodsModel alloc]init];
        model.defaultimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@", dic[@"defaultimg"]];
        model.productname = dic[@"productname"];
        model.productcost = [NSString stringWithFormat:@"%@RMB:",dic[@"productcost"]];
        model.TrademarkLabel = [NSString stringWithFormat:@"%@", dic[@"cp"]];
        model.productid =  dic[@"productid"];
        [arr addObject:model];
    }
    return arr;
}
@end
