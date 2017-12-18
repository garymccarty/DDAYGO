//
//  BetViewcell.h
//  DDAYGO
//
//  Created by Summer on 2017/12/16.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetViewcell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *but1Array;
@property (nonatomic, strong) NSMutableArray *but2Array;

@property (weak, nonatomic) IBOutlet UIView *butView;
@property (nonatomic ,assign) NSInteger wirteBetCount;
@property (nonatomic ,assign) NSInteger redBetCount;
- (void)updateCount:(NSInteger)count WithIndex:(NSInteger)row;
@end
