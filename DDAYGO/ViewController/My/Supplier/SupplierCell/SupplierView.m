//
//  SupplierView.m
//  DDAYGO
//
//  Created by Summer on 2017/12/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SupplierView.h"
#import "PrefixHeader.pch"
#define kATTR_VIEW_HEIGHT (kHeight-150)

///******* 屏幕尺寸 *******/
#define     kWidth      [UIScreen mainScreen].bounds.size.width - 150
#define     kHeight     [UIScreen mainScreen].bounds.size.height - 40
@interface SupplierView ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * contenView;
@end

@implementation SupplierView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
#pragma mark - public
/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    self.contenView.frame = CGRectMake(150, kHeight, kWidth, kATTR_VIEW_HEIGHT);;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        _weakSelf.contenView.frame = CGRectMake(150, kHeight - kATTR_VIEW_HEIGHT, kWidth, kATTR_VIEW_HEIGHT);
    }];
}

- (void)setupViews {
    __weak typeof (self) _weakSelf = self;
    CGRect frame = CGRectMake(150, kHeight, kWidth, kATTR_VIEW_HEIGHT);
    
    _weakSelf.backgroundColor = [UIColor clearColor];
    _weakSelf.contenView.frame = frame;
    
    //  添加手势，点击背景视图消失
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    tapBackGesture.delegate = self;
    [self addGestureRecognizer:tapBackGesture];
//****************
    
    UIView * bounceView = [UIView new];
    bounceView.backgroundColor = ZP_Graybackground;
    bounceView.layer.cornerRadius = 5.0;// View圆角弧度
    [self addSubview:bounceView];
    self.contenView = bounceView;
   
    self.contenView.frame = frame;
    [UIView animateWithDuration:0.3 animations:^{
    bounceView.frame = CGRectMake(150, 20, kWidth, kATTR_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *  属性视图的消失
 */
- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    
    CGRect frame = CGRectMake(150, kHeight, kWidth, kATTR_VIEW_HEIGHT);
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contenView.frame = frame;
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}

@end
