//
//  EditorViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/19.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "EditorViewController.h"
#import "PrefixHeader.pch"
#import "EditorViewCell.h"
@interface EditorViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger allNum;
    NSArray * dataArray;
}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UILabel * totle;//总计
@property(nonatomic,strong)UIButton * gotoPay;//支付
@property(nonatomic,strong)UIButton * selectImg;//全选
@property(nonatomic,strong)UILabel  * line;
@property(nonatomic,strong)UILabel * symo;//提示
@property(nonatomic,strong)NSMutableArray * arrData;
@property(nonatomic,strong)NSMutableArray * selectArr;//选中标示


@end

@implementation EditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavgationBar];
    [self initUI];
    [self.view setBackgroundColor:ZP_Graybackground];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    self.arrData = [[NSMutableArray alloc]init];
    self.selectArr = [[NSMutableArray alloc]init];
    self.title = NSLocalizedString(@"购物车", nil);
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    dataArray = @[@{@"title":@"Valvola法莫拉天然植物萃取保加利亚玫瑰纯露200ml",@"price":@"15",@"desc":@"250ml升级装",@"title2":@"Valvola法莫拉天然植物萃取保加利亚玫瑰纯露200ml",@"price2":@"15",@"desc2":@"250ml升级装"},
                  
  @{@"title":@"Valvola法莫拉天然植物萃取保加利亚玫瑰纯露200ml",@"price":@"15",@"desc":@"250ml升级装",@"title2":@"Valvola法莫拉天然植物萃取保加利亚玫瑰纯露200ml",@"price2":@"15",@"desc2":@"250ml升级装"},
                  
  @{@"title":@"Valvola法莫拉天然植物萃取保加利亚玫瑰纯露200ml",@"price":@"15",@"desc":@"250ml升级装",@"title2":@"Valvola法莫拉天然植物萃取保加利亚玫瑰纯露200ml",@"price2":@"15",@"desc2":@"250ml升级装"}];
/**** IOS 11 ****/
//    if (@available(iOS 11.0, *)) {
//        self.tableView.estimatedRowHeight = 0;
//        self.tableView.estimatedSectionHeaderHeight = 0;
//        self.tableView.estimatedSectionFooterHeight = 0;
//    }
}
/************************************************/
//  navigationBar按钮
- (void) setUpNavgationBar {
    
    static CGFloat const kButtonWidth = 33.0f;
    static CGFloat const kButtonHeight = 43.0f;
    
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0.0f, 0.0f, kButtonWidth, kButtonHeight);
    cartButton.backgroundColor = [UIColor clearColor];
    [cartButton setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
    cartButton.titleLabel.font = ZP_TooBarFont;
    [cartButton addTarget:self action:@selector(onClickedSweep:) forControlEvents:UIControlEventTouchUpInside];
    cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cartButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)onClickedSweep:(UIButton *)sup {
    
    self.hidesBottomBarWhenPushed = YES;
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"完成");
}
/************************************************/
// 表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
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
        make.top.equalTo(myView).offset(15);
    }];
    
//  店铺名称
    ZP_GeneralLabel * merchantsLabel = [ZP_GeneralLabel initWithtextLabel:_merchantsLabel.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
//    merchantsLabel.textAlignment = NSTextAlignmentLeft;
//    merchantsLabel.textColor = [UIColor blackColor];
    merchantsLabel.text = NSLocalizedString(@"阿芙专卖店", nil);
//    merchantsLabel.font = ZP_TooBarFont;
    [myView addSubview:merchantsLabel];
    [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(30);
        make.bottom.equalTo(myView).offset(- 10);
        make.right.equalTo(myView).offset(+ 50); // 右边
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
/************************************************/

- (void)initUI {
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    self.tableView.backgroundColor = ZP_Graybackground;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(- 60);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(10);
    }];
    static NSString * EditorID = @"editorViewCell";
    [self.tableView registerClass:[EditorViewCell class] forCellReuseIdentifier:EditorID];
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ZP_height - TabbarHeight, ZP_Width + TabbarHeight, TabbarHeight)];;
    bottomView.backgroundColor = ZP_textWite;
    [self.view addSubview:bottomView];
//  全选按钮
    self.AllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.AllButton.layer.masksToBounds = YES;
    self.AllButton.layer.cornerRadius = self.AllButton.frame.size.height/2;
    self.AllButton.layer.borderColor = [UIColor clearColor].CGColor;
    self.AllButton.layer.borderWidth = 1;
    [self.AllButton setTitle:NSLocalizedString(@"全选", nil) forState:UIControlStateNormal];
    self.AllButton.titleLabel.font = ZP_TooBarFont;
    [self.AllButton setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    [self.AllButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [self.AllButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    [self.AllButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.AllButton];
    [self.view addSubview:bottomView];
    self.AllButton = self.AllButton;
    [self.AllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(5); //左
        make.top.equalTo(bottomView).offset(10); // 下
        make.width.mas_offset(55);
        make.height.mas_offset(20);
    }];
    
//  删除按钮
    UIButton * ClearingBut = [UIButton new];
    ClearingBut.backgroundColor = ZP_pricebackground;
    [ClearingBut setTitle:NSLocalizedString(@"删除", nil) forState:UIControlStateNormal];
    ClearingBut.titleLabel.font = ZP_TooBarFont;
    [ClearingBut addTarget:self action:@selector(ClearingBut:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:ClearingBut];
    [ClearingBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(ZP_Width - 100);  //左边
        make.right.equalTo(self.view).offset(0); // 右边
        make.top.equalTo(bottomView).offset(0);
        make.height.mas_equalTo(50);
    }];
    _ClearingBut = ClearingBut;
}
//  全选
- (void)selectClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.AllButton == sender ) {
        for (int i = 0; i < dataArray.count; i ++) {
            EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.button.selected = sender.selected;
        }
    } else {
        EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
        cell.button.selected = sender.selected;
    }
    [self updateData];
}
//  店铺选择按钮
- (void)ShopClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.Shopchoosebuttom == sender) {
        for (int i = 0; i < dataArray.count; i ++) {
            EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.button.selected = sender.selected;
        }
    } else {
        EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
        cell.button.selected = sender.selected;
    }
    
    [self updateDataa];
}
- (void)updateData {
//   更新选中数量
    NSInteger count = 0;
    for (int i = 0; i < dataArray.count; i ++) {
        EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.button.selected ) {
            count ++;
        }
    }
    if (count == dataArray.count) {
        self.AllButton.selected = YES;
        self.Shopchoosebuttom.selected = YES;
    } else {
        self.AllButton.selected = NO;
        self.Shopchoosebuttom.selected = NO;
    }
}
- (void)updateDataa {
//   更新选中数量
    NSInteger count = 0;

    for (int i = 0; i < dataArray.count; i ++) {
        
        EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.button.selected ) {
            count ++;
        }
    }
    if (count == dataArray.count) {
        
        self.Shopchoosebuttom.selected = YES;
        
    } else {
        
        self.Shopchoosebuttom.selected = NO;
  }
}

//  删除按钮
- (void)ClearingBut:(UIButton *)sender {
    
    if ([self YESOrNoPush]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"确定要删除宝贝吗", nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * deletingFail = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            ZPLog(@"取消删除");
        }];
        UIAlertAction * deletingPass = [UIAlertAction actionWithTitle:NSLocalizedString(@"确认", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            ZPLog(@"删除成功");
        }];
        [alert addAction:deletingFail];
        [alert addAction:deletingPass];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }else {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"您还没有选择宝贝哦 ", nil)];
    }
}

- (BOOL)YESOrNoPush {
    for (int i = 0; i < dataArray.count; i ++) {
        EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.button.selected) {
            return YES;
        }
    }
    return NO;
}

#pragma mark tableviewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * EditorID = @"editorViewCell";
    EditorViewCell * cell = [tableView dequeueReusableCellWithIdentifier:EditorID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
    self.tableView.tableFooterView = [[UIView alloc] init];
    NSDictionary * dic = dataArray[indexPath.row];
    cell.button.tag = indexPath.row;
    [cell.button removeTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell cellWithDic:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    EditorViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.Reducebutton.selected = !cell.Reducebutton.selected;
    [self updateData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

@end
