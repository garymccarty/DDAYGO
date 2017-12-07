//
//  ZP_PayView.h
//  DDAYGO
//
//  Created by Summer on 2017/12/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZP_PayView : UIView
/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view;

/**
 *  属性视图的消失
 */
- (void)removeView;

//  支付成功
typedef void (^ConfirmPayBlock)(id response);
@property (nonatomic , copy) ConfirmPayBlock confirmPayBlock;

//  支付失败
typedef void (^PayFailBlock)(id response);
@property (nonatomic , copy) PayFailBlock PayFailBlock;

//  总计金额
@property (nonatomic, strong) UILabel * AmountLabel;

@end
