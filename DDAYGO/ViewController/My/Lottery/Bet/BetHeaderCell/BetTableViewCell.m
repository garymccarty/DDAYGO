//
//  BetTableViewCell.m
//  DDAYGO
//
//  Created by 赵宁 on 2017/11/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetTableViewCell.h"
#import "BetCollectionViewCell.h"

@implementation BetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.wirteBetCount = 69;
    self.redBetCount = 26;
    self.collrctionView.delegate = self;
    self.collrctionView.dataSource = self;
    [self.collrctionView registerNib:[UINib nibWithNibName:@"BetCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BetCollectionViewCell"];
    BetHeaderView *betHeaderView = [[NSBundle mainBundle] loadNibNamed:@"BetHeaderView" owner:self options:nil].lastObject;
    betHeaderView.frame = CGRectMake(0, 0, self.betHeaderView.frame.size.width, self.betHeaderView.frame.size.height);
    [self.betHeaderView addSubview:betHeaderView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ---collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.wirteBetCount;
}

- (void)updateCount:(NSInteger)count {
    self.wirteBetCount = count;
    [self.collrctionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/8, [UIScreen mainScreen].bounds.size.width/8);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BetCollectionViewCell" forIndexPath:indexPath];
    [cell setValue:indexPath.row + 1];
    return cell;
}

@end
