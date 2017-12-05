//
//  DetailedController.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "DetailedController.h"
#import "DetailedViewCell.h"
#import "TextdetailsViewCell.h"
#import "MerchantController.h"
#import "PrefixHeader.pch"
#import "ZP_ClassViewTool.h"
#import "ShopIntroductionViewController.h"
#import "ProductDescriptionView.h"
#import "ShoppingViewController.h"
#import "PurchaseView.h"
#import "UIImageView+WebCache.h"
#import "ZP_GoodDetailsModel.h"
#import "PurchaseView.h"
#import "ConfirmViewController.h"
@interface DetailedController ()<UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

//**Xib 拖过来然后填写数据**/
@property (nonatomic, strong)UIImageView * ShopImageView;
@property (weak, nonatomic) IBOutlet UILabel * ShopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel * ShopMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel * ShopOldMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel * quantityLable;
@property (weak, nonatomic) IBOutlet UILabel * peramountLable;
@property (weak, nonatomic) IBOutlet UILabel * productidLable;
@property (strong, nonatomic) IBOutlet UILabel * ShoppingIdLabel;


@property (nonatomic, strong) UITableView * tableviewVC;
@property (nonatomic, strong) UICollectionView * bottomVC;
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) UIWindow * window;
@property (nonatomic, strong) ProductDescriptionView * productDescriptionView;
@property (nonatomic, strong) PurchaseView * purchaseView;
@property (nonatomic ,strong) NSMutableArray * newsData;
@property (weak, nonatomic) IBOutlet UIButton *ljgmBtn;
@property (weak, nonatomic) IBOutlet UIButton *jrgwcBtn;
@property (nonatomic, strong) ZP_GoodDetailsModel * model;

@property (nonatomic, strong) NSArray * normsArr;
@property (nonatomic, strong) NSArray * typeArr;

@end

@implementation DetailedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allData];
    self.navigationController.navigationBar.hidden = YES;
    //    [_bottomVC registerClass:[DetailedViewCell class] forCellWithReuseIdentifier:@"detailedViewCell"];
    [_tableviewVC registerClass:[TextdetailsViewCell class] forCellReuseIdentifier:@"textdetailsViewCell"];
    [self.view addSubview:self.bottomVC];
    self.shfwBottomView.hidden = YES;
    self.qbpjBottomView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//updateViewConstraints
- (void)getimageData {
    if (_normsArr.count > 0) {
        NSLog(@"%ld",_normsArr.count);
        self.onScrollViewWidth.constant = ZP_Width * _normsArr.count;
        for (int i = 0; i < _normsArr.count; i ++) {
            ZP_GoodDetailsModel *model = _normsArr[i];
            _ShopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZP_Width * i, 0, ZP_Width, self.onScrollView.height)];
            _ShopImageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255. green:arc4random_uniform(256)/255. blue:arc4random_uniform(256)/255. alpha:1];
            [_ShopImageView sd_setImageWithURL:[NSURL URLWithString:model.cnimg] placeholderImage:[UIImage imageNamed:@""]];
            [self.onScrollView addSubview:_ShopImageView];
        }
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.smallScrollView.center.x - 19.5, self.smallScrollView.size.height - 37, 39, 37)];
        self.pageControl.numberOfPages = _normsArr.count;
        self.pageControl.currentPage = 0;
        [self.scrollView addSubview:self.pageControl];
        [self.shoucangBtn resizeWithDistance:5];
        [self.gouwuBtn resizeWithDistance:5];
        [self.dianpuBtn resizeWithDistance:5];
    }
    else{
        self.onScrollViewWidth.constant = ZP_Width * 1;
        for (int i = 0; i < 1; i ++) {
            _ShopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZP_Width * i, 0, ZP_Width, self.onScrollView.height)];
            _ShopImageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255. green:arc4random_uniform(256)/255. blue:arc4random_uniform(256)/255. alpha:1];
            [self.onScrollView addSubview:_ShopImageView];
        }
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.smallScrollView.center.x - 19.5, self.smallScrollView.size.height - 37, 39, 37)];
        self.pageControl.numberOfPages = 1;
        self.pageControl.currentPage = 0;
        [self.scrollView addSubview:self.pageControl];
        
        [self.shoucangBtn resizeWithDistance:5];
        [self.gouwuBtn resizeWithDistance:5];
        [self.dianpuBtn resizeWithDistance:5];
    }
    
}
// 获取数据
- (void)allData {
    if (nil == _productId) {
        return;
    }
    NSDictionary * dic;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"token"]) {
        dic = @{@"productid":_productId,@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]};
    } else {
        dic = @{@"productid":_productId};
    }
    [ZP_ClassViewTool requDetails:dic success:^(id obj) {
        
        ZP_GoodDetailsModel * model = [ZP_GoodDetailsModel getGoodDetailsData:obj[@"products"][0]];
        _shoucangBtn.selected = [model.state boolValue];
        NSString *value = [obj objectForKey:@"colornorms"];
        if ((NSNull *)value == [NSNull null]) {
            NSLog(@"kkk");
        }else{
            NSArray *colorArr = obj[@"colornorms"];
            if (colorArr.count > 0) {
                _normsArr = [ZP_GoodDetailsModel arrayWithArray:obj[@"colornorms"]];
                _typeArr = [ZP_GoodDetailsModel arrayWithTypeArray:obj[@"colornorms"]];
                [self getimageData];
            }
            
        }
        _model = model;
        [self getDataWithModel:model];
        
    } failure:^(NSError * error) {
        ZPLog(@"%@", error);
    }];
}

- (void)getRightItemDataWithProducttypeid:(NSInteger)producttypeid {
    NSDictionary * dictt = @{@"productid":@"2",@"fatherid":[@(producttypeid + 1) stringValue]};
    [ZP_ClassViewTool requClassIficationrj:dictt success:^(id obj) {
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//填写数据
- (void)getDataWithModel:(ZP_GoodDetailsModel *)model {
    if (_normsArr.count < 1){
        [self getimageData];
        [_ShopImageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
        
    }
    _ShopNameLabel.text = model.productname;
    _ShopMoneyLabel.text = model.productprice;
    _quantityLable.text = model.quantity;
    _peramountLable.text = model.peramount;
    _productidLable.text = model.productid;
    _ShoppingIdLabel.text = model.TrademarkLabel;
    
}
//  自定义返回按钮
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
// 分享
- (IBAction)shareAction:(id)sender {
    
}

- (IBAction)editAction:(id)sender {
    
}

#pragma mark  - - 收藏
- (IBAction)shoucangAction:(UIButton *)sender {
    DD_CHECK_HASLONGIN;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"productid"] = _model.productid;
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (!sender.selected) {
        //收藏
        [ZP_ClassViewTool requshoucang:dic success:^(id obj) {
            sender.selected = !sender.selected;
            NSLog(@"收藏 %@",obj);
        } failure:^(NSError *error) {
             NSLog(@"error %@",error);
        }];
    }else{
        //取消收藏
        [ZP_ClassViewTool requCancelshoucang:dic success:^(id obj) {
            sender.selected = !sender.selected;
            NSLog(@"取消收藏 %@",obj);
        } failure:^(NSError *error) {
            NSLog(@"error %@",error);
        }];
    }
}

- (IBAction)ShoppingCartAction:(id)sender {
//
//    ShoppingViewController * Shopping = [[ShoppingViewController alloc]init];
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:Shopping animated:YES];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
//    self.hidesBottomBarWhenPushed = YES;
    
}

- (IBAction)dianpuAction:(id)sender {
    
    MerchantController * Merchant = [[MerchantController alloc]init];
    [self.navigationController pushViewController:Merchant animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
}

- (IBAction)xzflAction:(UIButton *)sender {
    DD_CHECK_HASLONGIN;
    if (!self.purchaseView) {
        static NSString * purchasseID = @"PurchaseView";
        self.purchaseView = [[NSBundle mainBundle] loadNibNamed:purchasseID owner:self options:nil].firstObject;
        self.purchaseView.frame = self.view.frame;
        self.purchaseView.model = _model;
        self.purchaseView.modeltypeArr = _typeArr;
        self.purchaseView.modelArr = _normsArr;
        [self.view addSubview:self.purchaseView];
    }
    
    [self.purchaseView show:^(id response) {
        NSLog(@"re = %@",response);
        [self.xzflBtn setTitle:response forState:UIControlStateNormal];
    }];
    __weak typeof(self) _weakSelf = self;
    self.purchaseView.finishBtnBlock = ^(id response) {
        NSLog(@"go");
        _weakSelf.hidesBottomBarWhenPushed = YES;
        _weakSelf.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        _weakSelf.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [_weakSelf.navigationController pushViewController:response animated:YES];
    };
}

- (IBAction)cpsmAction:(UIButton *)sender {
    DD_CHECK_HASLONGIN;
    if (!self.productDescriptionView) {
        self.productDescriptionView = [[NSBundle mainBundle] loadNibNamed:@"ProductDescriptionView" owner:self options:nil].firstObject;
        self.productDescriptionView.frame = self.view.frame;
        [self.view addSubview:self.productDescriptionView];
    }
    [self.productDescriptionView show];
}
- (IBAction)cpnrAction:(id)sender {
    self.cpnrBottomView.hidden = NO;
    self.qbpjBottomView.hidden = YES;
    self.shfwBottomView.hidden = YES;
}

- (IBAction)qupjAction:(id)sender {
    self.cpnrBottomView.hidden = YES;
    self.qbpjBottomView.hidden = NO;
    self.shfwBottomView.hidden = YES;
}

- (IBAction)shfwAction:(id)sender {
    self.cpnrBottomView.hidden = YES;
    self.qbpjBottomView.hidden = YES;
    self.shfwBottomView.hidden = NO;
}

//立即购买
- (IBAction)ligmAction:(UIButton *)sender {
    DD_CHECK_HASLONGIN;
    if (!self.purchaseView) {
        static NSString * purchasseID = @"PurchaseView";
        self.purchaseView = [[NSBundle mainBundle] loadNibNamed:purchasseID owner:self options:nil].firstObject;
        self.purchaseView.frame = self.view.frame;
        NSLog(@"%@",_model.productamount);
        self.purchaseView.model = _model;
        self.purchaseView.modeltypeArr = _typeArr;
        self.purchaseView.modelArr = _normsArr;
        [self.view addSubview:self.purchaseView];
    }
    
    [self.purchaseView show:^(id response) {
        [self.xzflBtn setTitle:response forState:UIControlStateNormal];
    }];
    __weak typeof(self) _weakSelf = self;
    self.purchaseView.finishBtnBlock = ^(id response) {
        NSLog(@"go");
        _weakSelf.hidesBottomBarWhenPushed = YES;
        _weakSelf.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:_weakSelf action:nil];  // 隐藏返回按钮上的文字
        _weakSelf.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [_weakSelf.navigationController pushViewController:response animated:YES];
        
    };
}
//加入购物车
- (IBAction)jrgwcAction:(UIButton *)sender {
    DD_CHECK_HASLONGIN;
    if (!self.purchaseView) {
        static NSString * purchasseID = @"PurchaseView";
        self.purchaseView = [[NSBundle mainBundle] loadNibNamed:purchasseID owner:self options:nil].firstObject;
        self.purchaseView.frame = self.view.frame;
        self.purchaseView.model = _model;
        self.purchaseView.modeltypeArr = _typeArr;
        self.purchaseView.modelArr = _normsArr;
        [self.view addSubview:self.purchaseView];
    }
    
    [self.purchaseView show:^(id response) {
        NSLog(@"re = %@",response);
        [self.xzflBtn setTitle:response forState:UIControlStateNormal];
    }];
    __weak typeof(self) _weakSelf = self;
    self.purchaseView.finishBtnBlock = ^(id response) {
        NSLog(@"go");
        _weakSelf.hidesBottomBarWhenPushed = YES;
        _weakSelf.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        _weakSelf.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [_weakSelf.navigationController pushViewController:response animated:YES];
    };
}


- (UICollectionView *)collectionView {
    if (_bottomVC == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _bottomVC = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 180) collectionViewLayout:layout];
        _bottomVC.delegate = self;
        _bottomVC.dataSource = self;
        _bottomVC.backgroundColor = [UIColor whiteColor];
//      自动适应
        _bottomVC.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    }
    return _bottomVC;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

//        static NSString * identify = @"detailedViewCell";
//        DetailedViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
//
//        return cell;

//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}
//  TableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    _tableviewVC = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 150)];
    layout.itemSize = CGSizeMake(375, 200);
    [_tableviewVC registerClass:[TextdetailsViewCell class] forCellReuseIdentifier:@"textdetailsViewCell"];
    _tableviewVC.delegate = self;
    _tableviewVC.dataSource = self;
    
    _smallScrollView.delegate = self;
    _tableviewVC.backgroundColor = [UIColor whiteColor];
    //     自动适应
    _tableviewVC.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    TextdetailsViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"textdetailsViewCell"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --- scrollView delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView == self.smallScrollView) {
        if (!velocity.y && velocity.x) {
            CGPoint point = *targetContentOffset;
            self.pageControl.currentPage = point.x/scrollView.width;
        }
    }
}
@end


