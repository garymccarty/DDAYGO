//
//  OrderViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//


#import "OrderViewController.h"
#import "FSScrollContentView.h"
#import "OrderViewController.h"
#import "PrefixHeader.pch"
#import "ZP_OrderController.h"
@interface OrderViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Order", nil);
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self setUpNavgationBar];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!DD_HASLOGIN) {
        LogregisterController *viewcontroller = [[LogregisterController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewcontroller animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        //        [self allData];
    }
}

- (void)setUpNavgationBar {
    
    ZPSearchBarBUtton * searchBar = [ZPSearchBarBUtton buttonWithType:UIButtonTypeCustom];
    searchBar.width = 30;
    searchBar.height = 25;
    [searchBar setImage:[UIImage imageNamed:@"nav_menu_search"] forState:UIControlStateNormal];
    [searchBar setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [searchBar addTarget:self action:@selector(onClikedSearchBar) forControlEvents:UIControlEventTouchUpInside];
    searchBar.adjustsImageWhenHighlighted = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
}

- (void)initUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, NavBarHeight, CGRectGetWidth(self.view.frame), 40) delegate:self indicatorType:0];
    self.titleView.titlesArr = @[NSLocalizedString(@"全部", nil),NSLocalizedString(@"待付款", nil),NSLocalizedString(@"待发货", nil),NSLocalizedString(@"待收货", nil),NSLocalizedString(@"评价", nil)];
    [self.view addSubview:_titleView];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString *title in self.titleView.titlesArr) {
        ZP_OrderController *vc = [[ZP_OrderController alloc]init];
        vc.titleStr = title;
        [childVCs addObject:vc];
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, NavBarHeight + 40, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.frame) - NavBarHeight - 40) childVCs:childVCs parentVC:self delegate:self];
    [self.view addSubview:_pageContentView];
}

#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSLog(@"222 %ld- %ld",endIndex,startIndex);
    self.pageContentView.contentViewCurrentIndex = endIndex;
    //    self.title = self.titleView.titlesArr[endIndex];
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSLog(@"111 %ld- %ld",endIndex,startIndex);
    self.titleView.selectIndex = endIndex;
    //    self.title = self.titleView.titlesArr[endIndex];
}

//  搜索框点击事件
- (void)onClikedSearchBar {
    SearchGooodsController * search = [SearchGooodsController new];
    UINavigationController * login = [[UINavigationController alloc]initWithRootViewController:search];
    [self presentViewController:login animated:YES completion:nil];
    NSLog(@"搜索框");
}

@end

