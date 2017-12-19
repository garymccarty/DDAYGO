//
//  BetSeleTableViewCell.h
//  DDAYGO
//
//  Created by Summer on 2017/12/16.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetSeleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *seleLabel;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIButton *deleBut;
- (void)updateCount:(NSArray *)arr;
@end
