//
//  BetCollectionViewCell.h
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton * countBtn;
- (void)setValue:(NSInteger)index;
@end
