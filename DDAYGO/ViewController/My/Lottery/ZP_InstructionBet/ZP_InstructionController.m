//
//  ZP_InstructionController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_InstructionController.h"
#import "ZP_InstructionTableViewCell.h"
@interface ZP_InstructionController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZP_InstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI {
   self.title = NSLocalizedString(@"玩转赏金", nil);
    [self.tableview registerNib:[UINib nibWithNibName:@"ZP_InstructionTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZP_InstructionTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_InstructionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_InstructionTableViewCell"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}
@end
