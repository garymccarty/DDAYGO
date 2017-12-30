//
//  ZP_MyHopageModel.h
//  DDAYGO
//
//  Created by Summer on 2017/12/8.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_MyHopageModel : NSObject

@property (nonatomic, strong) NSNumber * collecedcount; // 收藏
@property (nonatomic, strong) NSNumber * historycount; // 浏览

@end


@interface ZP_MyHopageModel2 : NSObject
@property (nonatomic, strong) NSNumber * state; // 供应商状态
@property (nonatomic, copy) NSString * stateString; // 供应商状态

@end
