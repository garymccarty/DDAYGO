//
//  ZP_ExtractModel.m
//  DDAYGO
//
//  Created by Summer on 2017/12/11.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ExtractModel.h"

@implementation ZP_ExtractModel

+ (instancetype)ExtractWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    };
    return self;
}

//+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
//    
//}
@end
