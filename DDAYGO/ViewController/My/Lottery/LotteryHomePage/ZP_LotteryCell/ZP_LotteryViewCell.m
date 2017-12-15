//
//  ZP_LotteryViewCell.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_LotteryViewCell.h"
#import "ZP_LotteryCollectionViewCell.h"
@implementation ZP_LotteryViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.wirteBetCount = 5;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    static NSString * LotteryID = @"ZP_LotteryCollectionViewCell";
    [self.collectionView registerNib:[UINib nibWithNibName:LotteryID bundle:nil] forCellWithReuseIdentifier:LotteryID];
}

#pragma mark -- Collectionview  delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.wirteBetCount;
}

- (void)updateCount:(NSInteger)count {
    self.wirteBetCount = count;
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(40, 40);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * LotteryID = @"ZP_LotteryCollectionViewCell";
    ZP_LotteryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryID forIndexPath:indexPath];
    [cell setValue:indexPath.row + 1];
    return cell;
}
@end
