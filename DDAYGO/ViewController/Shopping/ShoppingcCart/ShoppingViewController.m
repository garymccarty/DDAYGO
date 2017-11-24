//
//  ShoppingViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ShoppingViewController.h"
#import "PrefixHeader.pch"
#import "ZP_shoopingTool.h"
#import "ShoppingCell.h"
#import "EditorViewController.h"
#import "ConfirmViewController.h"
#import "ZP_ShoppingModel.h"
@interface ShoppingViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger allNum;
    NSArray * dataArray;
    NSArray * nameArray;
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)ZP_ShoppingModel *model;
@property(nonatomic,strong)NSString *stockids;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavgationBar];
    [self initUI];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.title = NSLocalizedString(@"Shopping", nil);
/**** IOS 11 ****/
if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self allData];
}
- (void)allData {
    [ZP_shoopingTool requesshoppingData:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] success:^(id obj) {
        ZPLog(@"%@",obj);
        NSDictionary * dic = [obj firstObject];
        ZPLog(@"%@",dic);
        _model = [ZP_ShoppingModel CreateWithDict:[obj firstObject]];
        dataArray = [ZP_CartsModel arrayWithArray:dic[@"cart"]];
        nameArray = [ZP_CartsShopModel arrayWithArray:obj];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//  navigationBar按钮
- (void) setUpNavgationBar {
    static CGFloat const kButtonWidth = 33.0f;
    static CGFloat const kButtonHeight = 43.0f;
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0.0f, 0.0f, kButtonWidth, kButtonHeight);
    cartButton.backgroundColor = [UIColor clearColor];
    [cartButton setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
    cartButton.titleLabel.font = ZP_TooBarFont;
    [cartButton addTarget:self action:@selector(onClickedSweep:) forControlEvents:UIControlEventTouchUpInside];
    cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cartButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

//  编辑
- (void)onClickedSweep:(UIButton *)sup {
    EditorViewController * Editor = [[EditorViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Editor animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //        if ([self YESOrNoPush]) {
    //
    //            EditorViewController * Editor = [[EditorViewController alloc]init];
    //
    //            self.hidesBottomBarWhenPushed = YES;
    //            [self.navigationController pushViewController:Editor animated:YES];
    //            self.hidesBottomBarWhenPushed = NO;
    //            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    //            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //        }else {
    //
    //            //  声明一个 UILabel 对象
    //            UILabel * tipLabel = [UILabel new];
    //            //  设置提示内容
    //            [tipLabel setText: NSLocalizedString(@"您还没有选择宝贝哦", nil)];
    //            tipLabel.backgroundColor = [UIColor blackColor];
    //            tipLabel.layer.cornerRadius = 5; // 圆角
    //            tipLabel.font = [UIFont systemFontOfSize:15];
    //            tipLabel.layer.masksToBounds = YES;
    //            tipLabel.textAlignment = NSTextAlignmentCenter;
    //            tipLabel.textColor = [UIColor whiteColor];
    //            [self.view addSubview:tipLabel];
    //            [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //                make.left.equalTo(self.view).offset(ZP_Width / 2 - 50);
    //                make.bottom.equalTo(self.view).offset(-220);
    //                make.width.mas_offset(145);
    //                make.height.mas_offset(30);
    //            }];
    //            //  设置时间和动画效果
    //            [UIView animateWithDuration:2.0 animations:^{
    //                tipLabel.alpha = 0.0;
    //            } completion:^(BOOL finished) {
    //                //  动画完毕从父视图移除
    //                [tipLabel removeFromSuperview];
    //            }];
    //            NSLog(@"没选选中，不跳");
    //        }
    
    NSLog(@"编辑");
}

- (void)initUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, ZP_Width, ZP_height-TabbarHeight -50) style:UITableViewStylePlain];
    self.tableView.backgroundColor = ZP_Graybackground;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
//    注册
    [self.tableView registerClass:[ShoppingCell class] forCellReuseIdentifier:@"shoppingCell"];
    UIView * bottomView = [UIView new];
    bottomView.backgroundColor = ZP_textWite;
    bottomView.frame = CGRectMake(0, ZP_height - TabbarHeight - 50, ZP_Width, 50);
    [self.view addSubview:bottomView];
    
//   全选按钮
    self.AllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.AllButton.layer.masksToBounds = YES;
    self.AllButton.layer.cornerRadius = self.AllButton.frame.size.height/2;
    self.AllButton.layer.borderColor = [UIColor clearColor].CGColor;
    self.AllButton.layer.borderWidth = 1;
    [self.AllButton setTitle:NSLocalizedString(@"Select All", nil) forState:UIControlStateNormal];
    self.AllButton.titleLabel.font = ZP_TooBarFont;
    [self.AllButton setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    [self.AllButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.AllButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [self.AllButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    [bottomView addSubview:self.AllButton];
    self.AllButton = self.AllButton;
    [self.AllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(5); // 左边
        make.bottom.equalTo(bottomView).offset(-15); // 下边
        make.width.mas_offset(55);
        make.height.mas_offset(20);
    }];
    
//    总金额
    UILabel * PriceLabel = [UILabel new];
    PriceLabel.textAlignment = NSTextAlignmentLeft;
    PriceLabel.textColor = ZP_TypefaceColor;
    PriceLabel.text = @"0";
    PriceLabel.font = ZP_TooBarFont;
    [bottomView addSubview:PriceLabel];
    [PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).offset(- 110);
        make.bottom.equalTo(bottomView).offset(-25);
    }];
    _PriceLabel = PriceLabel;
    
//    合计
    ZP_GeneralLabel * StatisticsLabel = [ZP_GeneralLabel initWithtextLabel:_StatisticsLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    //    StatisticsLabel.textAlignment = NSTextAlignmentLeft;
    StatisticsLabel.text = NSLocalizedString(@"TotalRMB:", nil);
    
    [bottomView addSubview:StatisticsLabel];
    [StatisticsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PriceLabel).offset(-65); // 左边
        make.bottom.equalTo(PriceLabel).offset(0); // 下
    }];
    _StatisticsLabel = StatisticsLabel;
    
//   结算按钮
    UIButton * ClearingBut = [UIButton new];
    ClearingBut.backgroundColor = ZP_pricebackground;
    [ClearingBut setTitle:NSLocalizedString(@"Clearing(0)", nil) forState:UIControlStateNormal];
    ClearingBut.titleLabel.font = ZP_TooBarFont;
    [ClearingBut addTarget:self action:@selector(ClearingBut:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:ClearingBut];
    [ClearingBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(ZP_Width - 100);  //左边
        make.right.equalTo(self.view).offset(0); // 右边
        make.top.equalTo(bottomView).offset(0); //上边
        make.height.mas_equalTo(50);
    }];
    _ClearingButt = ClearingBut;
}

//  全选
- (void)selectClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (self.AllButton == sender ) {
        for (int i = 0; i < dataArray.count; i ++) {
            ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.buttom.selected = sender.selected;
        }
    } else {
        
        ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
        cell.buttom.selected = sender.selected;
    }
    
    [self updateData];
    
}

//  店铺选择按钮
- (void)ShopClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.Shopchoosebuttom == sender) {
        for (int i = 0; i < dataArray.count; i ++) {
            ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.buttom.selected = sender.selected;
        }
    } else {
        ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
        cell.buttom.selected = sender.selected;
    }
    
    [self updateDataa];
}
- (void)updateData {
//   更新选中数量
    NSInteger count = 0;
    NSInteger data = 0;
    NSInteger dataCount = 0;
    for (int i = 0; i < dataArray.count; i ++) {
        ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        ZP_CartsModel *model = dataArray[i];
        if (cell.buttom.selected ) {
            NSArray *array = [cell.PriceLabel.text componentsSeparatedByString:@"RMB"];
            data += ([array.lastObject integerValue] * [cell.QuantityLabel.text integerValue]);
            dataCount += [cell.QuantityLabel.text integerValue];
            count ++;
            NSString *str = [NSString stringWithFormat:@"%@_%@",model.stockid,model.amount];
            if (_stockids.length > 0) {
                _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
            }else{
                _stockids = str;
            }
        }
    }
    if (count == dataArray.count) {
        self.AllButton.selected = YES;
        self.Shopchoosebuttom.selected = YES;
    } else {
        self.AllButton.selected = NO;
        self.Shopchoosebuttom.selected = NO;
    }
//   更新合计数据
    self.PriceLabel.text = [@(data) stringValue];
    [self.ClearingButt setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)dataCount] forState: UIControlStateNormal];
}

- (void)updateDataa {
//   更新选中数量
    NSInteger count = 0;
    NSInteger data = 0;
    NSInteger dataCount = 0;
    for (int i = 0; i < dataArray.count; i ++) {
        
        ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        ZP_CartsModel *model = dataArray[i];
        if (cell.buttom.selected ) {
            
            NSArray *array = [cell.PriceLabel.text componentsSeparatedByString:@"RMB"];
            data += ([array.lastObject integerValue] * [cell.QuantityLabel.text integerValue]);
            dataCount += [cell.QuantityLabel.text integerValue];
            count ++;
            NSString *str = [NSString stringWithFormat:@"%@_%@",model.stockid,model.amount];
            if (_stockids.length > 0) {
                _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
            }else{
                _stockids = str;
            }
        }
    }
    
    if (count == dataArray.count) {
        
        self.Shopchoosebuttom.selected = YES;
        
    } else {
        
        self.Shopchoosebuttom.selected = NO;
        
    }
//   更新合计数据
    self.PriceLabel.text = [@(data) stringValue];
    [self.ClearingButt setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)dataCount] forState: UIControlStateNormal];
    allNum = dataCount;
}
#pragma mark - 结算
//  结算按钮
- (void)ClearingBut:(UIButton *)sender {
    _stockids = nil;
    [self updateData];
    if ([self YESOrNoPush]) {
        ConfirmViewController * Confirm = [[ConfirmViewController alloc]init];
        Confirm.model = _model;
        Confirm.dataArray = dataArray;
        Confirm.nameArray = nameArray;
        Confirm.PriceStr = _PriceLabel.text;
        Confirm.NumStr = self.ClearingButt.titleLabel.text;
        Confirm.stockidsString = _stockids;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Confirm animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
    }else {
        
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"You have not selected goods ", nil)];
        NSLog(@"没选选中，不跳");
    }
}

- (BOOL)YESOrNoPush {
    for (int i = 0; i < dataArray.count; i ++) {
        ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        if (cell.buttom.selected) {
            return YES;
        }
    }
    return NO;
}

#pragma mark tableviewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (nameArray.count) {
        return nameArray.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShoppingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
    self.tableView.tableFooterView = [[UIView alloc] init];
    ZP_CartsModel *model = dataArray[indexPath.row];
    cell.buttom.tag = indexPath.row;
    [cell.buttom removeTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.buttom addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell cellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}


// 表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZP_CartsShopModel *model;
    if (nameArray.count > 0) {
        model = nameArray[section];
    }
    UIView *myView = [[UIView alloc]init];
    self.tableView.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:[UIColor whiteColor]];
    
//  商店选择按钮
    self.Shopchoosebuttom = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.Shopchoosebuttom setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [self.Shopchoosebuttom setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    self.Shopchoosebuttom.layer.masksToBounds = YES;
    self.Shopchoosebuttom.layer.cornerRadius = self.Shopchoosebuttom.frame.size.height/2;
    self.Shopchoosebuttom.layer.borderColor = [UIColor clearColor].CGColor;
    self.Shopchoosebuttom.layer.borderWidth = 1;
    [self.Shopchoosebuttom addTarget:self action:@selector(ShopClick:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:self.Shopchoosebuttom];
    [self.Shopchoosebuttom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(5);
        make.top.equalTo(myView).offset(10);
    }];
    
//  店铺名称
    ZP_GeneralLabel * merchantsLabel = [ZP_GeneralLabel initWithtextLabel:_merchantsLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    merchantsLabel.text = NSLocalizedString(model.shopname, nil);
    [myView addSubview:merchantsLabel];
    [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_Shopchoosebuttom).offset(25);
        make.top.equalTo(myView).offset(15);
        make.height.mas_offset(15);
        make.width.mas_offset(80);
    }];
    _merchantsLabel = merchantsLabel;
//  横线
    UIView * view0 = [UIView new];
    view0.backgroundColor = ZP_Graybackground;
    [myView addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(5);  // 左
        make.right.equalTo(myView).offset(ZP_Width); // 长
        make.bottom.equalTo(myView).offset(- 1); // 下
        make.height.mas_equalTo(1); // 高
    }];
    return myView;
}
//  设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



@end

