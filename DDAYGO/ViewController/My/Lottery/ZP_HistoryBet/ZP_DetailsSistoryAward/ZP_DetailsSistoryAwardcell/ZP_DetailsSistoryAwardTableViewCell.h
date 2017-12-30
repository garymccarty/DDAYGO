//
//  ZP_DetailsSistoryAwardTableViewCell.h
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_LotterModel.h"

@interface ZP_DetailsSistoryAwardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton * butt1;
@property (weak, nonatomic) IBOutlet UIButton * butt2;
@property (weak, nonatomic) IBOutlet UIButton * butt3;
@property (weak, nonatomic) IBOutlet UIButton * butt4;
@property (weak, nonatomic) IBOutlet UIButton * butt5;
@property (weak, nonatomic) IBOutlet UIButton * butt6;
- (void)HistoryBet:(lotteryorderModel *)model;
@end
