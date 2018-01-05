//
//  ZP_PayView.m
//  DDAYGO
//
//  Created by Summer on 2017/12/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_PayView.h"
#import "PrefixHeader.pch"
#define kATTR_VIEW_HEIGHT (kHeight-215)

///******* 屏幕尺寸 *******/
#define     kWidth      [UIScreen mainScreen].bounds.size.width - 30
#define     kHeight     [UIScreen mainScreen].bounds.size.height - 5

@interface ZP_PayView ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView * contentView;
@property (nonatomic, strong) UIButton * Creditcardbut;
@property (nonatomic, strong) UIButton * ICUEbut;
@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) NSArray * InformatonArray;

@end

@implementation ZP_PayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - setupViews
/**
 *  设置视图的基本内容
 */
- (void)setupViews {
    //  添加手势，点击背景视图消失
    UIView * bounceView = [UIView new];
    bounceView.backgroundColor = [UIColor whiteColor];
    bounceView.layer.cornerRadius = 5.0;// View圆角弧度
    [self addSubview:bounceView];
    self.contentView = bounceView;
    [bounceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(200);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.mas_offset(ZP_Width);
    }];
    //  取消按钮
    UIButton * Cancelbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [Cancelbut setImage:[UIImage imageNamed:@"ic_payment_cancel"] forState:UIControlStateNormal];
    [Cancelbut addTarget:self action:@selector(cancelbut:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    tapBackGesture.delegate = self;
    [self addGestureRecognizer:tapBackGesture];
    [bounceView addSubview:Cancelbut];
    [Cancelbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bounceView).offset(10);
        make.top.equalTo(bounceView).offset(10);
    }];
    //  标题
    UILabel * titleLabel = [UILabel new];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textColor = ZP_textblack;
    titleLabel.text = @"确认付款";
    titleLabel.numberOfLines = 0;
    titleLabel.font = ZP_addBtnTextdetaFont;
    [bounceView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(215); // 上面
        make.left.equalTo(self).offset(ZP_Width / 2  - 30); // 左边
    }];
    
    for (int z = 0; z <= 3; z ++) {
        for (int i = 0; i <=2; i ++) {
            for (int x = z; x <=1; x ++) {
                self.view = [[UIView alloc]initWithFrame:CGRectMake(i * ZP_Width, z *  50+ 50 + x * 150, ZP_Width , 1)];
                [self.view setBackgroundColor:ZP_DeepBlue];
                [bounceView addSubview:self.view];
            }
        }
    }
    
    //  金额
    UILabel * AmountLabel = [UILabel new];
    AmountLabel.textColor = [UIColor blackColor];
    AmountLabel.textColor = ZP_textblack;
    //    AmountLabel.text = @"￥600.00";
    AmountLabel.font = ZP_AmountTextFont;
    [bounceView addSubview:AmountLabel];
    [AmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(280); // 上面
        make.left.equalTo(self).offset(ZP_Width / 2 - 50); // 左边
    }];
    _AmountLabel = AmountLabel;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary * dic = _InformatonArray[0];
        CGFloat f = [[dic[@"Preferential"] stringByReplacingOccurrencesOfString:@"NT" withString:@""] floatValue];
        CGFloat r = [dic[@"Cost"] floatValue];
        _AmountLabel.text = [NSString stringWithFormat:@"NT%.2f",f* [dic[@"Quantiy"] floatValue] + r];
    });
    
    
    //  信用卡image
    UIImageView * Creditcardimageview = [UIImageView new];
    [bounceView addSubview:Creditcardimageview];
    Creditcardimageview.image = [UIImage imageNamed:@"icon_creditcard"];
    [Creditcardimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bounceView).offset(10);
        make.top.equalTo(bounceView).offset(165);
    }];
    
    //  信用卡支付
    UILabel * CreditcardLabel = [UILabel new];
    CreditcardLabel.textColor = [UIColor blackColor];
    CreditcardLabel.textColor = ZP_textblack;
    CreditcardLabel.text = NSLocalizedString(@"信用卡支付", nil);
    CreditcardLabel.font = ZP_addBtnTextdetaFont;
    [bounceView addSubview:CreditcardLabel];
    [CreditcardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bounceView).offset(45);
        make.top.equalTo(bounceView).offset(170);
    }];
    
    //  信用卡选择按钮
    UIButton * Creditcardbut = [UIButton new];
    [Creditcardbut setImage:[UIImage imageNamed:@"icon_payment_selected_pressed"] forState:UIControlStateNormal];
    [Creditcardbut setImage:[UIImage imageNamed:@"icon_payment_selected_normal"] forState:UIControlStateSelected];
    [Creditcardbut addTarget:self action:@selector(creditcardbut:) forControlEvents:UIControlEventTouchUpInside];
    Creditcardbut.layer.masksToBounds = YES;
    Creditcardbut.layer.cornerRadius = Creditcardbut.frame.size.height / 2;
    Creditcardbut.layer.borderColor = [UIColor clearColor].CGColor;
    Creditcardbut.layer.borderWidth = 1;
    [Creditcardbut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    [bounceView addSubview:Creditcardbut];
    _Creditcardbut = Creditcardbut;
    [Creditcardbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bounceView).offset(-15);
        make.top.equalTo(bounceView).offset(165);
    }];
    
    //  ICUEimage
    UIImageView * ICUEimageview = [UIImageView new];
    [bounceView addSubview:ICUEimageview];
    ICUEimageview.image = [UIImage imageNamed:@"ic_icue_coins"];
    [ICUEimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bounceView).offset(10);
        make.top.equalTo(bounceView).offset(215);
    }];
    
    //  ICUE支付
    ZP_GeneralLabel * ICUELabel = [UILabel new];
    ICUELabel.textColor = [UIColor blackColor];
    ICUELabel.textColor = ZP_textblack;
    ICUELabel.text = NSLocalizedString(@"ICUE支付", nil);
    ICUELabel.font = ZP_addBtnTextdetaFont;
    [bounceView addSubview:ICUELabel];
    [ICUELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bounceView).offset(45);
        make.top.equalTo(bounceView).offset(220);
    }];
    
    //  ICUE选择按钮
    UIButton * ICUEbut = [UIButton new];
    [ICUEbut setImage:[UIImage imageNamed:@"icon_payment_selected_normal"] forState:UIControlStateNormal];
    [ICUEbut setImage:[UIImage imageNamed:@"icon_payment_selected_pressed"] forState:UIControlStateSelected];
    [ICUEbut addTarget:self action:@selector(iCUEbut:) forControlEvents:UIControlEventTouchUpInside];
    ICUEbut.layer.masksToBounds = YES;
    ICUEbut.layer.cornerRadius = ICUEbut.frame.size.height / 2;
    ICUEbut.layer.borderColor = [UIColor clearColor].CGColor;
    ICUEbut.layer.borderWidth = 1;
    [ICUEbut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    _ICUEbut = ICUEbut;
    [bounceView addSubview:ICUEbut];
    [ICUEbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bounceView).offset(-15);
        make.top.equalTo(bounceView).offset(215);
    }];
    
    //  支付按钮
    UIButton * Paybut = [UIButton new];
    Paybut.titleLabel.font = ZP_TooBarFont;
    Paybut.layer.borderColor = [UIColor clearColor].CGColor;
    Paybut.backgroundColor = ZP_PayColor;
    Paybut.layer.cornerRadius = 5.0;// 圆角弧度
    [Paybut setTitle:NSLocalizedString(@"立即支付", nil) forState:UIControlStateNormal];
    [Paybut addTarget:self action:@selector(paybut:) forControlEvents:UIControlEventTouchUpInside];
    [bounceView addSubview:Paybut];
    [Paybut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-25);
        make.height.mas_offset(40);
    }];
}
#pragma mark - 按钮选择
//  信用卡选择按钮
- (void)creditcardbut:(UIButton *)sender {
    sender.selected = !sender.selected;
    _Creditcardbut.selected = NO;
    if (_Creditcardbut == sender) {
        _ICUEbut.selected = NO;
    }
    NSLog(@"选中信用卡");
}

//  ICUE 按钮选择
- (void)iCUEbut:(UIButton *)sender {
    _ICUEbut.selected = YES;
    if (_ICUEbut == sender) {
        _Creditcardbut.selected = YES;
    }
    NSLog(@"选中IUCE");
}

#pragma mark - 点击支付按钮
- (void)paybut:(UIButton *)sender {
    
        NSLog(@"支付");
}

#pragma mark - 点击事件
- (void)cancelbut:(UIButton * )sup {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}
#pragma mark - UIGestureRecognizerDelegate
//  确定点击范围
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
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
    self.contentView.frame = CGRectMake(15, kHeight, kWidth, kATTR_VIEW_HEIGHT);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _weakSelf.contentView.frame = CGRectMake(15, kHeight - kATTR_VIEW_HEIGHT, kWidth, kATTR_VIEW_HEIGHT);
    }];
}

/**
 *  属性视图的消失
 */
- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contentView.frame = CGRectMake(15, kHeight, kWidth, kATTR_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}


@end
