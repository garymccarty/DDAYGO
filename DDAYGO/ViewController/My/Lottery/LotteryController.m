//
//  LotteryController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LotteryController.h"
#import "ZP_LotteryCell.h"
#import "PrefixHeader.pch"
@interface LotteryController () 

@end

@implementation LotteryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubView];
    self.title = NSLocalizedString(@"彩票", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
}

-(void)addSubView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc ]init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;  //横向滚动 默认上下
    _bottonVC = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 30, 30) collectionViewLayout:layout];
    _bottonVC.backgroundColor = [UIColor whiteColor];
    
    _bottonVC.delegate = self;
    _bottonVC.dataSource = self;
    [self.view addSubview:_bottonVC];
    [self addSubView];
    self.bottonVC = _bottonVC;
    [_bottonVC registerClass:[ZP_LotteryCell class] forCellWithReuseIdentifier:@"Cells"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 69;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZP_LotteryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cells" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中%ld",(long)indexPath.item);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(10, 10);
}
@end
