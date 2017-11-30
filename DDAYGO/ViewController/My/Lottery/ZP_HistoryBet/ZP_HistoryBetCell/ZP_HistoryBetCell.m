//
//  ZP_HistoryBetCell.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_HistoryBetCell.h"
#import "ZP_HistoryBetCollectionCell.h"
#import "ZP_HistoryBetView.h"
@implementation ZP_HistoryBetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.wirteBetCount = 6;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    static NSString * collectionID = @"ZP_HistoryBetCollectionCell";
    [self.collectionView registerNib:[UINib nibWithNibName:collectionID bundle:nil] forCellWithReuseIdentifier:collectionID];
    ZP_HistoryBetView * BetView = [[NSBundle mainBundle] loadNibNamed:@"ZP_HistoryBetView" owner:self options:nil].lastObject;
    BetView.frame = CGRectMake(0, 0, self.HistoryBetView.frame.size.width, self.HistoryBetView.frame.size.height);
    [self.HistoryBetView addSubview:BetView];
    
}

#pragma mark -- collectionview delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.wirteBetCount;
}

- (void)updateCount:(NSInteger)count {
    self.wirteBetCount = count;
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/8, [UIScreen mainScreen].bounds.size.width/8);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ZP_HistoryID = @"ZP_HistoryBetCollectionCell";
    ZP_HistoryBetCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZP_HistoryID forIndexPath:indexPath];
    [cell setValue:indexPath.row + 1];
    return cell;
}

@end
