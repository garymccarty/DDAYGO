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
    self.title = @"我的足迹";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self.collectionView registerNib:[UINib nibWithNibName:@"FootprintCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FootprintCollectionViewCell"];
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.collectionView.alwaysBounceVertical = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self allData];
}

- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    int i = arc4random_uniform(999);  // 随机数
    dic[@"nonce"] = @(i);
    [ZP_MyTool requtsFootprint:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSDictionary * dic = obj;
        self.newsData = [ZP_FootprintModel arrayWithArray:dic[@"historyslist"]];
        if (self.newsData.count < 1) {
            UIImageView * image = [UIImageView new];
            image.image = [UIImage imageNamed:@"icon_fail"];
            [self.view addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(ZP_Width / 2 -25);
                make.top.equalTo(self.view).offset(ZP_Width / 2 - 25);
                make.width.mas_offset(50);
                make.height.mas_equalTo(50);
            }];
            ZP_GeneralLabel * RemindLabel = [ZP_GeneralLabel initWithtextLabel:_RemindLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentCenter bakcgroundColor:ZP_WhiteColor];
            RemindLabel.text = @"数据空空如也";
            [self.view addSubview:RemindLabel];
            [RemindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(ZP_Width / 2 -30);
                make.top.equalTo(image).offset(55);
                make.height.mas_offset(15);
            }];
        }
        [self.collectionView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"error");
    }];
}

#pragma mark --- collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.newsData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FootprintCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FootprintCollectionViewCell" forIndexPath:indexPath];
    cell.deleBtn.tag = indexPath.row;
    [cell.deleBtn addTarget:self action:@selector(deleBtn:) forControlEvents:UIControlEventTouchUpInside];
    ZP_FootprintModel *model = self.newsData[indexPath.row];
    [cell FootprintCollection:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width=(self.view.frame.size.width-55)/3;
    return CGSizeMake(width, width *137 / 110);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

//  删除按钮
- (void)deleBtn:(UIButton *)btn{
    if (self.newsData.count == 0) {
       
        return;
    }
    ZP_FootprintModel *model = self.newsData[btn.tag];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"historyid"] = model.historyid;
    [ZP_MyTool requtsDeleFootprint:dic success:^(id obj) {
        NSLog(@"dele %@",obj);
        [self allData];
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        }else {
            if ([obj[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"删除失败"];
            }
        }
    } failure:^(NSError * error) {
        NSLog(@"dele %@",error);
    }];
}

- (NSMutableArray *)newsData {
    
    if (!_newsData) {
        _newsData = [NSMutableArray array];
    }
    return _newsData;
}

@end

