//
//  ConfirmViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ConfirmViewController.h"
#import "ZP_ConfirmViewCell.h"
#import "ZP_InformationCell.h"
#import "ZP_AnonymityViewCell.h"
#import "ConfirmPayView.h"
#import "ZP_ExpressDeliveryCell.h"
#import "AddressViewController.h"
#import "ZP_MessageViewCell.h"
#import "PayPassController.h"
#import "PayFailController.h"
#import "PrefixHeader.pch"
#import "ZP_ConfirmPayModel.h"
#import "ZP_shoopingTool.h"
#import "ZP_InformationModel.h"
#import "ZP_ComfirmModel.h"
#import "ZP_ConfirmPayModel.h"
#import "ZP_ConfirmWebController.h"

@interface ConfirmViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    NSArray * InformatonArray;
    NSArray * messageArray;
    
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArrar;
@property (nonatomic, strong)NSMutableArray * NewData;
@property (nonatomic, strong) NSMutableArray * ConfirmArray;
@property (nonatomic, strong) UILabel * merchantsLabel;


@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    ZPLog(@"_stockid = %@",_stockid);
    _dataArrar = [NSMutableArray array];
    _ConfirmArray = [NSMutableArray array];
    [self initUI];
    [self ImmobilizationView];
    self.title = NSLocalizedString(@"确认订单", nil);
    [self getAddData];
    [self MakeSureOrder];
    //    [self ExpressDelivery];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    InformatonArray = _dataArray;
    if (_PriceStr && _NumStr) {
        messageArray = @[@{@"Computations":_PriceStr,@"num":_NumStr}];
    }else {
        messageArray = @[@{@"Computations":@"",@"num":@""}];
    }
}

// UI
- (void)initUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height-49) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;  // 隐藏tableview线条
    self.tableView.backgroundColor = ZP_Graybackground;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //  注册
    static NSString * ConfirmViewID = @"confirmViewCell";
    static NSString * InformationID = @"informationCell";
    static NSString * AnonymityViewID = @"anonymity";
    static NSString * messageID = @"messageViewCell";
    static NSString * ExpressDeliveryID = @"expressDeliveryCell";
    [self.tableView registerClass:[ZP_ConfirmViewCell class] forCellReuseIdentifier:ConfirmViewID];
    [self.tableView registerClass:[ZP_InformationCell class] forCellReuseIdentifier:InformationID];
    [self.tableView registerClass:[ZP_ExpressDeliveryCell class] forCellReuseIdentifier:ExpressDeliveryID];
    [self.tableView registerClass:[ZP_MessageViewCell class] forCellReuseIdentifier:messageID];
    [self.tableView registerClass:[ZP_AnonymityViewCell class] forCellReuseIdentifier:AnonymityViewID];
    
}

- (void)ImmobilizationView {
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ZP_height - TabbarHeight , ZP_Width, 50)];
    bottomView.backgroundColor = ZP_textWite;
    [self.view addSubview:bottomView];
    //  总金额
    ZP_GeneralLabel * PriceLabel = [ZP_GeneralLabel initWithtextLabel:_PriceLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    PriceLabel.text = @"0";
    [bottomView addSubview:PriceLabel];
    [PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(- 110); // 右
        make.bottom.equalTo(self.view).offset(- 20); // 下
    }];
    _PriceLabel = PriceLabel;
    
    //  合计
    ZP_GeneralLabel * StatisticsLabel = [ZP_GeneralLabel initWithtextLabel:_StatisticsLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    StatisticsLabel.text = NSLocalizedString(@"合计RMB:", nil);
    [bottomView addSubview:StatisticsLabel];
    [StatisticsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PriceLabel).offset(- 65); // 右
        make.bottom.equalTo(self.view).offset(- 20); // 下
    }];
    _StatisticsLabel = StatisticsLabel;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        _PriceLabel.text = [NSString stringWithFormat:@"%.2f", [_PriceStr floatValue]];
//    });
    //  提交订单
    UIButton * Clearing = [UIButton new];
    Clearing.backgroundColor = ZP_pricebackground;
    [Clearing setTitle:NSLocalizedString(@"提交订单", nil) forState:UIControlStateNormal];
    Clearing.titleLabel.font = ZP_TooBarFont;
    [Clearing addTarget:self action:@selector(ClearingBut:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:Clearing];
    [Clearing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(ZP_Width - 100); // 左
        make.right.equalTo(self.view).offset(0);  // 右
        make.top.equalTo(bottomView).offset(0);
        make.height.mas_equalTo(50); // 高度
    }];
    _ClearingBut = Clearing;
    [self.view addSubview:bottomView];
}

//  组头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section ==1) {
        return 40;
    }else if (section == 4) {
        return 10;
    }else {
        return 0;
    }
}

// 提交订单
- (void)ClearingBut:(UIButton *)sender {
    [self ConfirmData];
    
}
// ConfirmView数据
- (void)ConfirmData {
    NSDictionary * dic = @{@"countrycode":@"886"};
    [ZP_shoopingTool requetMethodpay:dic success:^(id obj) {
        
        ConfirmPayView * PayView = [[ConfirmPayView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        PayView.AmountLabel.text = _PriceLabel.text;
        PayView.dataArray = [ZP_ConfirmPayModel arrayWithArray:obj];
        PayView.confirmPayBlock = ^(id response) {
            
        };
        
        PayView.ConfirmPayMoneyBlock = ^(id response) {
            ZP_ConfirmPayModel * model = response;
            NSLog(@"payname = %@",model.payname);
            ZP_ComfirmModel *modell = _dataArrar[0];
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            dic[@"adsid"] = modell.addressid;
            dic[@"stockids"] =_stockidsString;
            dic[@"logistic"] = @1;
            dic[@"payway"] = model.payid;
            dic[@"leavemsg"] = @"nihaoya";
            dic[@"icuetoken"] = @"";
            __weak typeof(PayView) weakView = PayView;
            [ZP_shoopingTool requessaddorderpay:dic success:^(id json) {
                ZP_ConfirmWebController * web = [[ZP_ConfirmWebController alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
                self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
                self.hidesBottomBarWhenPushed = YES;
                NSString * urlStr = [NSString stringWithFormat:@"%@%@",json[@"uri"],json[@"para"]];
                web.UrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                NSURL * url = [NSURL URLWithString:urlStr];
//                NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
                
//                web.UrlStr = [NSString stringWithFormat:@"%@?%@",json[@"uri"],json[@"para"]];
                
                [weakView removeView];
                [self.navigationController pushViewController:web animated:YES];
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        };
        
        [PayView showInView:self.view];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

// 确认地址
- (void)getAddData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    dic[@"stockids"] = self.stockidsString;
    [ZP_shoopingTool requesMakeSureOrder:dic success:^(id obj) {
        NSDictionary * dic = obj;
        NSArray * modelArr = [ZP_ComfirmModel arrayWithArray:dic[@"receipts"]];
        [modelArr enumerateObjectsUsingBlock:^(ZP_ComfirmModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([model.isdefault isEqualToNumber:@1]) {
                NSLog(@"%@",model.isdefault);
                self.merchantsLabel.text = model.receiptname;
                [_dataArrar addObject:model];
            }
        }];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}
// 获取确认订单
- (void)MakeSureOrder {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    dic[@"stockids"] = self.stockidsString;
    //    stockids：库存字符串，库存ID与数量拼接，多个用逗号连接，如：42_2,43_1
    [ZP_shoopingTool requesMakeSureOrder:dic success:^(id obj) {
        NSDictionary * dic = obj;
        ZPLog(@"%@",dic);
        self.NewData = [ZP_InformationModel arrayWithArray:dic[@"carts"]];
        ZP_ExpressDeliveryModel *model = [[ZP_ExpressDeliveryModel alloc] init];
        model.freightamount = dic[@"freightamount"];
        model.chooselogistic = dic[@"chooselogistic"];
        [_ConfirmArray addObject:model];
        [self upfataStatisticsLabel];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        
    }];
}

- (void)upfataStatisticsLabel {
    float asd = 0.0;
    for (ZP_InformationModel *model in self.NewData) {
        asd += model.amount.intValue * model.productprice.floatValue;
    }
    
    self.PriceLabel.text = [NSString stringWithFormat:@"%.2f",asd];
}

// 快递费
- (void)ExpressDelivery {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    dic[@"stockids"] = self.stockidsString;
    [ZP_shoopingTool requesMakeSureOrder:dic success:^(id obj) {
        //        NSDictionary * dic = obj;
        NSLog(@"freightamount : %@",obj[@"freightamount"]);
        //        self.ConfirmArray = [ZP_ExpressDeliveryModel arrayWithArray:obj[@"freightamount"]];
        
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        
    }];
}
#pragma Mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return _dataArrar.count;
    }else
        if (1 == section) {
            //        return InformatonArray.count;
            return self.NewData.count;
        }else
            if (2 == section) {
                return self.ConfirmArray.count;
            }else {
                
                return _dataArrar.count;
            }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString * ID = @"confirmViewCell";
        ZP_ConfirmViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        self.tableView.tableFooterView = [[UIView alloc] init];
        ZP_ComfirmModel * model = _dataArrar[indexPath.row];
        [cell cellWithDic:model];
        return cell;
        
    }else
        if (indexPath.section == 1){
            static NSString * ID = @"informationCell";
            ZP_InformationCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
            self.tableView.tableFooterView = [[UIView alloc]init];
            ZP_InformationModel * model = self.NewData[indexPath.row];
            [cell InformationWithDic:model];
            return cell;
            
        }else
            if (indexPath.section ==2){
                static NSString * ExpressDeliveryID = @"expressDeliveryCell";
                ZP_ExpressDeliveryCell * cell = [tableView dequeueReusableCellWithIdentifier:ExpressDeliveryID];
                self.tableView.tableFooterView = [[UIView alloc]init];
                ZP_ExpressDeliveryModel * model = self.ConfirmArray[indexPath.row];
                [cell ExpressDevliveryDic:model];
                return cell;
                
            }else
                if (indexPath.section == 3){
                    static NSString * messageID = @"messageViewCell";
                    ZP_MessageViewCell * cell = [tableView dequeueReusableCellWithIdentifier:messageID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;  // 取消cell点击变灰
                    self.tableView.tableFooterView = [[UIView alloc]init];
                    if (self.NewData.count > indexPath.row) {
                        ZP_InformationModel *model = self.NewData[indexPath.row];
                        [cell MessageDic:model];
                    }
                    
                    return cell;
                    
                }else {
                    static NSString * AnonymityID = @"anonymity";
                    ZP_AnonymityViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AnonymityID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
                    [cell.AnonymousButton removeTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.AnonymousButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                    
                }
}
- (void)selectClick:(UIButton *)sup {
    
    if (sup.selected == 0) {
        NSLog(@"取消");
    }else
        if (sup.selected == 1) {
            NSLog(@"选中");
        }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 90;
        
    }else
        if (indexPath.section == 1){
            
            return 95;
            
        }else
            if (indexPath.section == 2){
                
                return 45;
                
            }else
                if (indexPath.section == 3){
                    
                    return 90;
                    
                }else {
                    
                    return 45;
                }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        self.hidesBottomBarWhenPushed = YES;
        AddressViewController * addres = [[AddressViewController alloc]init];
        [self.navigationController pushViewController:addres animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
        
    }
}

//  表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    if (section ==1) {
        ZP_CartsShopModel *model = _nameArray[section-1];
        UIView * myView = [[UIView alloc]init];
        //        if (1 == section) {
        //        self.tableView.tableHeaderView = myView; // 表头跟着cell一起滚动
        //        }
        [myView setBackgroundColor:[UIColor whiteColor]];
        /********************************************/
        UIView * view = [[UIView alloc]init];
        [view setBackgroundColor:ZP_Graybackground];
        [myView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myView).offset(0);
            make.right.equalTo(myView).offset(0);
            make.top.equalTo(myView).offset(1);
            make.bottom.equalTo(myView).offset(-30);
        }];
        
        //   商家图片
        UIImageView * merchantsImage = [UIImageView new];
        merchantsImage.image = [UIImage imageNamed:@"ic_order_store"];
        [myView addSubview:merchantsImage];
        [merchantsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myView).offset(5);
            make.top.equalTo(myView).offset(20);
        }];
        
        //    商家名字
        UILabel * merchantsLabel = [UILabel new];
        merchantsLabel.textAlignment = NSTextAlignmentLeft;
        merchantsLabel.textColor = ZP_textblack;
        merchantsLabel.text = NSLocalizedString(model.shopname, nil);
        merchantsLabel.font = ZP_titleFont;
        [myView addSubview:merchantsLabel];
        [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myView).offset(30);
            make.top.equalTo(myView).offset(20);
        }];
        self.merchantsLabel = merchantsLabel;
        return myView;
        
    }else {
        return 0;
    }
    
}

@end


