//
//  BetHeaderView.h
//  DDAYGO
//
//  Created by 赵宁 on 2017/11/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, DDColorBet)
{
    DDRedBet        = 0,
    DDWriteBet      = 1,
};

@interface BetHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *colorBetLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *individual;

- (void)updateViewWithColor:(DDColorBet)colorBet TotalCount:(NSInteger)totalCount SelectedCount:(NSInteger)selectedCount;

@end
