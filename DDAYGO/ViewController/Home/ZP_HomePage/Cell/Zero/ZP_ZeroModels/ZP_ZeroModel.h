//
//  ZP_ZeroModel.h
//  DDAYGO
//
//  Created by Summer on 2017/10/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_ZeroModel : NSObject
@property (nonatomic, strong) NSString * detaImage;


+ (instancetype)getHeadlineData:(NSDictionary *)Dic;
@end
