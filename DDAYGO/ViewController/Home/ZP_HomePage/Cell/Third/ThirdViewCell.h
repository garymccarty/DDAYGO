//
//  ThirdViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewCell : UITableViewCell

@property (nonatomic, copy) void(^ThirdBlock)(NSInteger tag);
@property (nonatomic, strong) UILabel * Titlelabel; // 标题

- (void)Third:(NSArray *)sup;
@end
