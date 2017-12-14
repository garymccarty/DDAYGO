//
//  FourthViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FourthViewCell.h"
#import "PrefixHeader.pch"
#import "CustomCell.h"
#import "ZP_HomeTool.h"
#import "ZP_FifthModel.h"
//#import "CustomCell-B.h"
@interface FourthViewCell ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray * CustomAArray;
}

@property (nonatomic, strong) UITableView * tableView;

@end
@implementation FourthViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"Fourthcell"];
    if (self) {
        [self initUI];
        [self CustomCell];
        [self Registration];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)initUI {
//    标题
    ZP_GeneralLabel * Titlelabel = [ZP_GeneralLabel initWithtextLabel:_Titlelabel.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    Titlelabel.textAlignment = NSTextAlignmentCenter;
//    [Titlelabel setTextColor:ZP_Graybackground];
//    Titlelabel.textColor = ZP_textblack;
//    Titlelabel.font = ZP_TooBarFont;
    [self addSubview:Titlelabel];
    [Titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(7);
    }];
    _Titlelabel = Titlelabel;
    
//  分割线
    UIView * view0 = [UIView new];
    view0.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(29.5);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(ZP_Width);
        make.height.mas_equalTo(1);
    }];
    
//  图片1
    UIImageView * imageView1 = [UIImageView new];
    [self addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(160);
    }];
    _imageView1 = imageView1;
    
    //  图片2
    UIImageView * imageView2 = [UIImageView new];
    [self addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(190);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(80);
    }];
    _imageView2 = imageView2;
    
    //  图片3
    UIImageView * imageView3 = [UIImageView new];
    [self addSubview:imageView3];
    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(270);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(80);
    }];
    _imageView3 = imageView3;
}
- (void)InformationWithDic:(NSDictionary *)dic {
    
    _Titlelabel.text = dic[@"title"];
    _imageView1.image = [UIImage imageNamed:@"img_home_advertisemen"];
    [self allData];
}

- (void)allData {
    NSDictionary * dict = @{@"count":@"5",@"countrycode":@"886"};
    [ZP_HomeTool requestSellLikeHotCakes:dict success:^(id obj) {
        NSArray * arr = obj;
        for (int i = 0; i < 2; i ++) {
            NSDictionary *dic = arr[i];
            if (i == 0) {
                [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ddaygo.com%@",dic[@"defaultimg"]]]];
            } else {
                [_imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ddaygo.com%@",dic[@"defaultimg"]]]];
            }
        }
//        for (NSDictionary *dic in arr) {
//            model.defaultimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@",dic[@"defaultimg"]];
//            model.productname = dic[@"productname"];
//            model.producid = dic[@"productid"];
//            model.PreferentialLabel = [NSString stringWithFormat:@"%@",dic[@"productprice"]];
//            model.TrademarkLabel = [NSString stringWithFormat:@"%@",dic[@"cp"]];
//        }
        // NSLog(@"%@",dic[@""]);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
/*****************************************************/
//  定制Cell
- (void)CustomCell {
    CustomAArray = @[@{@"Titlelabel":@"RFFP burberry 天然植物萃取让你有话说不出...",@"Preferentia":@"RMB:1000.00",@"Price":@"RMB:1200.00",@"Trademark":@"6666"}];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    self.tableView.backgroundColor = ZP_Graybackground;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;  // 设置tableview不能上下滚动
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.bottom.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(30);
    }];
    
}
//  注册
- (void)Registration {
    
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"customCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        CustomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
        NSDictionary * dic = CustomAArray[indexPath.row];
        [cell InformationWithDic:dic];
        return cell;
    
   }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        return 80;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ThirdBlock) {
        self.ThirdBlock(indexPath.row);
    }
        NSLog(@"111");
}
@end
