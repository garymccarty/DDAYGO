//
//  ZP_DetailsSistoryAwardTableViewCell.h
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZP_DetailsSistoryAwardTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger wirteBetCount;
@property (nonatomic, assign) NSInteger redBetCount;
- (void)updateCount:(NSInteger)count;
@end
