//
//  AppraiseController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "AppraiseController.h"
#import "AppraiseViewCell.h"
#import "ShopevaluationViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "PrefixHeader.pch"
@interface AppraiseController ()
@property (nonatomic, strong) UITableView * tableview;
@end

@implementation AppraiseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"发布评论", nil);
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self initUI];
    [self setUpNavgationBar];
}

- (void)initUI {
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, ZP_Width, ZP_height)];
    dataArray = @[@{@"":@""}];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    [self.tableview registerClass:[AppraiseViewCell class] forCellReuseIdentifier:@"prefixHeader"];
    [self.tableview registerClass:[ShopevaluationViewCell class] forCellReuseIdentifier:@"shopevaluation"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = ZP_Graybackground;
    [self.view addSubview:self.tableview];
}

//  navigationBar按钮
- (void) setUpNavgationBar {
    static CGFloat const kButtonWidth = 33.0f;
    static CGFloat const kButtonHeight = 43.0f;
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0.0f, 0.0f, kButtonWidth, kButtonHeight);
    cartButton.backgroundColor = [UIColor clearColor];
    [cartButton setTitle:NSLocalizedString(@"发布", nil) forState:UIControlStateNormal];
    cartButton.titleLabel.font = ZP_TooBarFont;
    [cartButton addTarget:self action:@selector(cartButton:) forControlEvents:UIControlEventTouchUpInside];
    cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cartButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)cartButton:(UIButton *)cartbut {
    
//    UIView * myView = [UIView new];
//    myView.backgroundColor = ZP_DeepBlue;
//    myView.layer.cornerRadius = 5; // 圆角
//    [self.view addSubview:myView];
//    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(ZP_Width / 2 - 50);
//        make.top.equalTo(self.view).offset(ZP_Width / 2 );
//        make.width.mas_offset(80);
//        make.height.mas_offset(25);
//    }];
////  添加一张图片
//    UIImageView * image = [UIImageView new];
//    image.image = [UIImage imageNamed:@"icon_successful"];
//    [self.view addSubview:image];
//    [image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(myView).offset(2.5);
//        make.top.equalTo(myView).offset(2.5);
//        make.width.mas_offset(20);
//        make.height.mas_offset(20);
//    }];
////  声明一个 UILabel 对象
//    UILabel * tipLabel = [UILabel new];
////  设置提示内容
//    [tipLabel setText: NSLocalizedString(@"评价成功", nil)];
//    tipLabel.font = ZP_stockFont;
//    tipLabel.layer.masksToBounds = YES;
//    tipLabel.textAlignment = NSTextAlignmentRight;
//    tipLabel.textColor = [UIColor whiteColor];
//    [self.view addSubview:tipLabel];
//    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(image).offset(22.5);
//        make.top.equalTo(image).offset(2.5);
//    }];
    
//  设置时间和动画效果
    [UIView animateWithDuration:8.0 animations:^{
        [SVProgressHUD showSuccessWithStatus:@"评价成功"];
    } completion:^(BOOL finished) {
//  动画完毕从父视图移除
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
//        NSLog(@"没选选中，不跳");
    }


#pragma mark - <UItableviewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSArray * A = @[@"a",@"b",@"c",@"d",@"e"];
        NSString * AppraiseID = @"prefixHeader";
        AppraiseViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AppraiseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        cell.scoreBlock = ^(NSInteger tag) {
            NSLog(@"%ld",(long)tag);
        };
        [cell score:A];
        
        NSDictionary * dic = dataArray[indexPath.row];
        [cell Appraise:dic];
        return cell;

    }else {
        
        NSArray * B = @[@"a",@"b",@"c",@"d",@"e"];
        NSString * ShopevaluationID = @"shopevaluation";
        ShopevaluationViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopevaluationID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        cell.ShopevaluationBlock = ^(NSInteger tag) {
            NSLog(@"%ld",(long)tag);
        };
        [cell Shopevaluation:B];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 150;
    }else {
       return 160;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
