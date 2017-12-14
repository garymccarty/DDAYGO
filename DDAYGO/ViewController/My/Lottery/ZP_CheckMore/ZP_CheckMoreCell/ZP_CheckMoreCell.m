//
//  ZP_CheckMoreCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_CheckMoreCell.h"
#import "ZP_CheckMoreCollectionCell.h"
@implementation ZP_CheckMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.CheckMoreCollectionView registerNib:[UINib nibWithNibName:@"ZP_CheckMoreCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ZP_CheckMoreCollectionCell"];
}

#pragma mark -- Collectionview  delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(30, 30);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ZP_CheckMoreCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZP_CheckMoreCollectionCell" forIndexPath:indexPath];
    [cell setValue:indexPath.row + 1];
    return cell;
}
@end
