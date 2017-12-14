//
//  ZP_CheckMoreCell.h
//  DDAYGO
//
//  Created by Summer on 2017/12/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZP_CheckMoreCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel * OrderNumberLabel;  // 订单号
@property (weak, nonatomic) IBOutlet UIView * TitleView;
@property (weak, nonatomic) IBOutlet UICollectionView * CheckMoreCollectionView;
@property (nonatomic, assign) NSInteger wirteBetCount;
@property (nonatomic, assign) NSInteger redBetCount;





@end
