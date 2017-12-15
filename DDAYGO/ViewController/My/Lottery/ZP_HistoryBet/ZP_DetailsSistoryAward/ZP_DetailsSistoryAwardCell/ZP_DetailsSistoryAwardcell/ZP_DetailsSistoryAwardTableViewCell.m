//
//  ZP_DetailsSistoryAwardTableViewCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_DetailsSistoryAwardTableViewCell.h"
#import "ZP_DetailsSistoryAwardCell.h"
@implementation ZP_DetailsSistoryAwardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.wirteBetCount = 5;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    static NSString * DetailsSistoryAwardID = @"ZP_DetailsSistoryAwardCell";
    [self.collectionView registerNib:[UINib nibWithNibName:DetailsSistoryAwardID bundle:nil] forCellWithReuseIdentifier:DetailsSistoryAwardID];
    
}

#pragma mark -- CollectionView delegate
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

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ZP_HistoryID = @"ZP_DetailsSistoryAwardCell";
    ZP_DetailsSistoryAwardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZP_HistoryID forIndexPath:indexPath];
    [cell setValue:indexPath.row + 1];
    return cell;
}
@end
