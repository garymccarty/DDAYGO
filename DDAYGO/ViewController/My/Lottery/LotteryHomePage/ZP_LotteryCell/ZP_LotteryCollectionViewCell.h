//
//  ZP_LotteryCollectionViewCell.h
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZP_LotteryCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIButton * countBut;
- (void)setValue:(NSInteger)index;
@end
