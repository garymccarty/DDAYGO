//
//  BetTableViewCell.h
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetHeaderView.h"

@interface BetTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet BetHeaderView * betHeaderView;
@property (weak, nonatomic) IBOutlet UICollectionView *collrctionView;
@property (nonatomic ,assign) NSInteger wirteBetCount;
@property (nonatomic ,assign) NSInteger redBetCount;
- (void)updateCount:(NSInteger)count;
@end
