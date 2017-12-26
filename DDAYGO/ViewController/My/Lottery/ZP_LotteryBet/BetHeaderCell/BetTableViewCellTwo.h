//
//  BetTableViewCellTwo.h
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetTableViewCellTwo : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleBut;

- (void)updateCount:(NSArray *)arr;

@end
