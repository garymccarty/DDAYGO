//
//  FifthViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FifthViewCell.h"
#import "PrefixHeader.pch"
#import "ReuseCollectionViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "ZP_HomeTool.h"
#import "ZP_FifthModel.h"

@interface FifthViewCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *bottomCV;
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong)NSMutableArray * newsData;

@end
@implementation FifthViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"ceaaa"];
    if (self) {
        
        [self addSubViews];
        [self allData];
        
    }
    return self;
}
- (void)addSubViews {
    //    NSDictionary * dic = @{@"image":@"Fifth",@"title":@"大尺码 吸汗排湿 圆领T恤 短袖...",@"Preferential":@"RMB:888.88",@"price":@"RMB:888.88",@"Trademark":@"6666"};
    //    _array = @[dic,dic,dic,dic,dic,dic];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc ]init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;  //横向滚动 默认上下
    _bottomCV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 150) collectionViewLayout:layout];
    _bottomCV.backgroundColor = [UIColor whiteColor];
    
    _bottomCV.delegate = self;
    _bottomCV.dataSource = self;
    
    [self addSubview:_bottomCV];
    self.bottomCV = _bottomCV;
    [_bottomCV registerClass:[ReuseCollectionViewCell class] forCellWithReuseIdentifier:@"Cells"];
}

- (void)allData {
    
    NSDictionary * dict = @{@"count":@"5",@"countrycode":@"886"};
    [ZP_HomeTool requestSellLikeHotCakes:dict success:^(id obj) {
        NSArray * arr = obj;
        self.newsData = [ZP_FifthModel arrayWithArray:arr];
        [self.bottomCV reloadData];
        // NSLog(@"%@",dic[@""]);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.newsData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ReuseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cells" forIndexPath:indexPath];
    ZP_FifthModel * model = self.newsData[indexPath.row];
    [cell cellWithdic:model];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ThirdBlock) {
        self.ThirdBlock(indexPath.row);
    }
    NSLog(@"选中%ld",(long)indexPath.item);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(ZP_Width/4-1, 150);
}

@end
