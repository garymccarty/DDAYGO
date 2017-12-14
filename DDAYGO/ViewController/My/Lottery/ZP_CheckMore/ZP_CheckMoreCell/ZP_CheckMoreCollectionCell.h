//
//  ZP_CheckMoreCollectionCell.h
//  DDAYGO
//
//  Created by Summer on 2017/12/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZP_CheckMoreCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton * countBut;
- (void)setValue:(NSInteger)index;
@end
