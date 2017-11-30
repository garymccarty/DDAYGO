//
//  BetHeaderView.h
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
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
