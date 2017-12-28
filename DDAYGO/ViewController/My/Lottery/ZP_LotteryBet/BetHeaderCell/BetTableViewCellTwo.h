//
//  BetTableViewCellTwo.h
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetTableViewCellTwo : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton * deleBut;
@property (weak, nonatomic) IBOutlet UIView *jiajianVIEw;
@property (weak, nonatomic) IBOutlet UIButton *jianBut;
@property (weak, nonatomic) IBOutlet UILabel *shuliangLabel;
@property (weak, nonatomic) IBOutlet UIButton *jiaBut;

- (void)updateCount:(NSArray *)arr;

@end
