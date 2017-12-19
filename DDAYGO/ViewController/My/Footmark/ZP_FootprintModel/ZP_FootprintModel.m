//
//  ZP_FootprintModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_FootprintModel.h"

@implementation ZP_FootprintModel

+ (instancetype)gEtFootprint:(NSDictionary *)Dic {
    return [[self alloc]initWithFootprintData:Dic];
}

- (instancetype)initWithFootprintData:(NSDictionary *)dic {
    if (self == [super init]) {
        self.defaultimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@",dic[@"defaultimg"]];
        self.productname = dic[@"productname"];
        self.productprice = [NSString stringWithFormat:@"%@",dic[@"productprice"]];
        self.cp = [NSString stringWithFormat:@"%@",dic[@"cp"]];
         self.CurrencySymbolLabel = @"RMB:";
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
    if (array.count > 0) {

    for (NSDictionary * dic in array[0][@"historylist"]) {
        
        ZP_FootprintModel * model = [[ZP_FootprintModel alloc]init];
        model.defaultimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@",dic[@"defaultimg"]];
        model.productname = dic[@"productname"];
        model.productprice = [NSString stringWithFormat:@"%@",dic[@"productprice"]];
        model.cp = [NSString stringWithFormat:@"%@",dic[@"cp"]];
        model.historyid = dic[@"historyid"];
        model.CurrencySymbolLabel = @"RMB:";
        [arr addObject:model];
    }
        
    }
    return arr;
}
@end
