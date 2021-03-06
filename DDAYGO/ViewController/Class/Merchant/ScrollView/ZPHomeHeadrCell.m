//
//  ZPHomeHeadrCell.m
//  merchants
//
//  Created by Summer on 2017/9/18.
//  Copyright © 2017年 PENG.ZHANG. All rights reserved.
//

#import "ZPHomeHeadrCell.h"
#import "PrefixHeader.pch"
@interface ZPHomeHeadrCell ()
@property (nonatomic, strong)UIImageView * iconView;
@property (nonatomic, strong)UILabel * titleLabel;

@end


@implementation ZPHomeHeadrCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    UIImageView * iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = ZP_titleFont;
    titleLabel.textColor = [UIColor grayColor];
    [self addSubview:titleLabel];
    self.iconView = iconView;
    self.titleLabel = titleLabel;
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    self.iconView.image = [UIImage imageNamed:imageName];
}
- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(15, 15, self.frame.size.width - 30, self.frame.size.height - 30);
    self.titleLabel.frame = CGRectMake(0, 75, self.frame.size.width, 21);
}

@end
