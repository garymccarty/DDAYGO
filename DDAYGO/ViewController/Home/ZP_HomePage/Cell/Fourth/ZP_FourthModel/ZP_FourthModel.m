//
//  ZP_FourthModel.m
//  DDAYGO
//
//  Created by Summer on 2017/10/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_FourthModel.h"

@implementation ZP_FourthModel
+ (instancetype)getFourthData:(NSDictionary *)Dic {
    return [[self alloc]initWithFourthData:Dic];
}

- (instancetype)initWithFourthData:(NSDictionary *)Dic {
    if (self == [super init]) {
        self.dataImage = Dic[@"dataImage"];
    }
    return self;
}

+ (id)cheakNull:(id)dic {
    if ([dic isEqual:[NSNull null]]) {
        return @"";
    }
    return dic;
}
@end
