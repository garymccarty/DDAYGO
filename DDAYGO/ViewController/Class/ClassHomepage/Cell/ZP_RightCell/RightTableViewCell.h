//
//  RightTableViewCell.h
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_RightModel.h"
@interface RightTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel * contentLabel;

- (void)updateData:(ZP_RightModel *)model;
@end
