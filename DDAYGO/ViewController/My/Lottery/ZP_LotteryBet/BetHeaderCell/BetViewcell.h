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
@property (nonatomic, copy) void(^arrayBlock)(NSArray *arr1,NSArray *arr2);
@property (weak, nonatomic) IBOutlet UIView *butView;
@property (nonatomic ,assign) NSInteger wirteBetCount;
@property (nonatomic ,assign) NSInteger redBetCount;

@property (weak, nonatomic) IBOutlet UILabel *l1;
@property (weak, nonatomic) IBOutlet UILabel *l2;
@property (weak, nonatomic) IBOutlet UILabel *l3;
@property (weak, nonatomic) IBOutlet UILabel *l4;

/**
 *
 */
@property (weak, nonatomic) IBOutlet UILabel *redlabel;
@property (weak, nonatomic) IBOutlet UILabel *howLabel;


- (void)updateCount:(NSInteger)count WithIndex:(NSInteger)row;
@end
