//
//  ZP_InstructionController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_InstructionController.h"
#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
#import "ZP_InstructionBetModel.h"
@interface ZP_InstructionController ()

@end

@implementation ZP_InstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self AllData];
}

- (void)initUI {
   self.title = NSLocalizedString(@"玩轉促銷彩", nil);

}

- (void)AllData {
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    dic[@"token"] = Token;
    [ZP_MyTool requestLotterynow:Token uccess:^(id obj) {
        ZPLog(@"%@",obj);
//        NSMutableDictionary * dic = obj[@"lotterywin"];
//        ZP_InstructionBetModel * model = obj[1][@"lotterywin"];
        
//        [self initWithINstruction:model];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

//- (void)initWithINstruction:(ZP_InstructionBetModel *)Model {
//    _referAndBonusLabel1.text = [Model.winamount stringValue];
//}

@end
