//
//  ZP_InstructionController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_InstructionController.h"
#import "ZP_InstructionTableViewCell.h"
@interface ZP_InstructionController ()

@end

@implementation ZP_InstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI {
   self.title = NSLocalizedString(@"玩转赏金", nil);

}

@end
