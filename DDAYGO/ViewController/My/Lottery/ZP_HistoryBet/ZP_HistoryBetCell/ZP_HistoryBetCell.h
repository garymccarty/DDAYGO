//
//  ZP_HistoryBetCell.h
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZP_HistoryBetCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView * collectionView;
@property (strong, nonatomic) IBOutlet UIView * HistoryBetView;
@property (nonatomic, assign) NSInteger wirteBetCount;
@property (nonatomic, assign) NSInteger redBetCount;
- (void)updateCount:(NSInteger)count;

@end
