//
//  ZP_CheckMoreController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_CheckMoreController.h"
#import "ZP_CheckMoreCell.h"
@interface ZP_CheckMoreController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView * tableview;

@end

@implementation ZP_CheckMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"本期下注号码", nil);
    [self.tableview registerNib:[UINib nibWithNibName:@"ZP_CheckMoreCell" bundle:nil] forCellReuseIdentifier:@"ZP_CheckMoreCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_CheckMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_CheckMoreCell"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}
@end
