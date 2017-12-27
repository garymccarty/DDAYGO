//
//  FirstViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewCell : UITableViewCell

@property (nonatomic, copy) void(^firstBlock)(NSInteger tag);
@property (nonatomic, strong) NSString * menuname;
//@property (nonatomic, copy) void(^firstBlock)(NSInteger name);

- (void)first:(NSArray *)sup;

@end
