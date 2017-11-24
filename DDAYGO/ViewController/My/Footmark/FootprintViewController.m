//
//  FootprintViewController.m
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FootprintViewController.h"
#import "UINavigationBar+Awesome.h"
#import "FootprintCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface FootprintViewController ()

@property (nonatomic, strong)NSMutableArray * newsData;
@end

@implementation FootprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allData];
    self.title = @"我的足迹";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self.collectionView registerNib:[UINib nibWithNibName:@"FootprintCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FootprintCollectionViewCell"];
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

}
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
   int i = arc4random_uniform(999);  // 随机数
    dic[@"nonce"] = @(i);
    [ZP_MyTool requtsFootprint:dic success:^(id obj) {
        NSArray * arr = obj;
        ZPLog(@"%@",arr);
    } failure:^(NSError * error) {
        
    }];
}
#pragma mark --- collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FootprintCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FootprintCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width=(self.view.frame.size.width-51)/3;
    return CGSizeMake(width, width *137 / 110);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


@end
