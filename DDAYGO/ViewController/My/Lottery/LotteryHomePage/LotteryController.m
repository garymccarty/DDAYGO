//
//  LotteryController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LotteryController.h"
#import "ZP_LotteryCell/ZP_LotteryViewCell.h"
#import "PrefixHeader.pch"
#import "BetViewController.h"
#import "ZP_HistoryVetController.h"
#import "ZP_InstructionController.h"
@interface LotteryController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (strong ,nonatomic) NSArray *titleArray;
@property (strong ,nonatomic) NSArray *titleLabelArray;
@property (strong ,nonatomic) NSArray *titleWidthArray;

@property (strong ,nonatomic) NSArray *prizeArray;
@property (strong ,nonatomic) NSArray *winningNumbArray;
@property (strong ,nonatomic) NSArray *currentPeriodArray;
@property (strong ,nonatomic) NSArray *winnersNumArray;
@property (strong ,nonatomic) NSArray *bountyArray;

@end

@implementation LotteryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
//    [self updateBounctyViewWithBonus:614278265 Suffix:@"$"];
}

//- (CGSize)getStringSize:(NSString *)string FontSize:(NSInteger)fontSize Size:(CGSize)size {
//    CGSize size1;
//    CGSize widthSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:fontSize]} context:nil].size;
//    size1.width = widthSize.width+1;
//    size1.height = widthSize.height+1;
//    return size1;
//}

//- (void)updateViewConstraints {
//    [super updateViewConstraints];
//    CGFloat onScrollViewWidth = 0;
//    CGFloat compensateValue = 0;
//    for (int i = 0; i < self.titleArray.count; i ++) {
//        UILabel *tempLabtl = self.titleLabelArray[i];
//        NSLayoutConstraint *tempLayoutCont =self.titleWidthArray[i];
//        tempLayoutCont.constant = [self getStringSize:tempLabtl.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
//        onScrollViewWidth += tempLayoutCont.constant;
//    }
//    
//    if (onScrollViewWidth > [UIScreen mainScreen].bounds.size.width - 16 + 50) {
//        compensateValue = 16;
//        onScrollViewWidth += 5 * 16;
//    } else {
//        compensateValue = ([UIScreen mainScreen].bounds.size.width - 16 - onScrollViewWidth) /5;
//        onScrollViewWidth = [UIScreen mainScreen].bounds.size.width - 16;
//    }
//    
//    for (NSLayoutConstraint *tempLayoutCont in self.titleWidthArray) {
//        tempLayoutCont.constant += compensateValue;
//    }
//    self.onScrollViewWidth.constant = onScrollViewWidth;
//}

- (void)initUI {
    self.title = NSLocalizedString(@"赏金彩", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
    
    static NSString * LotteryID = @"ZP_LotteryViewCell";
    [self.tableView registerNib:[UINib nibWithNibName:LotteryID bundle:nil] forCellReuseIdentifier:LotteryID];
    self.tableView.separatorStyle = UITableViewRowAnimationNone; // 隐藏tableview线条
    UIToolbar * tools = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, -15, 15)];
// 解决出现的那条线
    tools.clipsToBounds = YES;
// 解决tools背景颜色的问题
    [tools setBackgroundImage:[UIImage new]forToolbarPosition:UIBarPositionAny                      barMetrics:UIBarMetricsDefault];
    [tools setShadowImage:[UIImage new]
       forToolbarPosition:UIToolbarPositionAny];
//  添加两个button
    NSMutableArray * buttons = [[NSMutableArray alloc]initWithCapacity:2];
    
    UIBarButtonItem * Instruction = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bg_lottery_record"] style: UIBarButtonItemStyleDone target:self action:@selector(Instruction)];
    
    UIBarButtonItem * HistoryLottery = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bg_lottery_explan"] style: UIBarButtonItemStyleDone target:self action:@selector(HistoryLottery)];
    Instruction.tintColor=[UIColor whiteColor];
    HistoryLottery.tintColor=[UIColor whiteColor];
    [buttons addObject:HistoryLottery];
    [buttons addObject:Instruction];
    [tools setItems:buttons animated:NO];
    UIBarButtonItem * btn =[[UIBarButtonItem alloc]initWithCustomView:tools];
    self.navigationItem.rightBarButtonItem = btn;
    
//    self.titleArray = @[@"奖项",@"对中奖号数",@"本期各奖项金额",@"中奖数",@"赏金金额"];
//    self.titleLabelArray = @[self.prizeLabel,self.winningNumbLabel,self.currentPeriodLabel,self.winnersNumLabel,self.bountyLabel];
//    self.titleWidthArray = @[self.prizeWidth,self.winningNumbWidth,self.currentPeriodWidth,self.winnersNumWidth,self.bountyWidth];
//    self.prizeArray = @[self.prizeLabel1,self.prizeLabel2,self.prizeLabel3,self.prizeLabel4];
//    self.winningNumbArray = @[self.winningNumbLabel1,self.winningNumbLabel2,self.winningNumbLabel3,self.winningNumbLabel4];
//    self.currentPeriodArray = @[self.currentPeriodLabel1,self.currentPeriodLabel2,self.currentPeriodLabel3,self.currentPeriodLabel4];
//    self.winnersNumArray = @[self.winnersNumLabel1,self.winnersNumLabel2,self.winnersNumLabel3,self.winnersNumLabel4];
//    self.bountyArray = @[self.bountyLabel1,self.bountyLabel2,self.bountyLabel3,self.bountyLabel4];
//
//    NSArray *prizeArray = @[@"头奖",@"二奖",@"三奖",@"四奖"];
//    NSArray *winnersNumArray = @[@"白球五个+红球一个",@"白球五个",@"白球四个",@"白球三个"];
//    for (int i = 0; i < prizeArray.count; i ++) {
//        UILabel *tempPrizeLabel = self.prizeArray[i];
//        UILabel *tempWinningNumbLabel = self.winningNumbArray[i];
//        UILabel *tempCurrentPeriodLabel = self.currentPeriodArray[i];
//        UILabel *tempWinnersNumLabel = self.winnersNumArray[i];
//        UILabel *tempBountyLabel = self.bountyArray[i];
//
//        tempPrizeLabel.text = prizeArray[i];
//        tempWinningNumbLabel.text = winnersNumArray[i];
//        tempCurrentPeriodLabel.text = nil;
//        tempWinnersNumLabel.text = nil;
//        tempBountyLabel.text = nil;
//    }
}

#pragma mark  更新赏金视图
//- (void)updateBounctyViewWithBonus:(NSInteger)bonus Suffix:(NSString *)suffix {
//    for (UIView *view in self.bounctyView.subviews) {
//        [view removeFromSuperview];
//    }
//
//    NSString *bonusString = @(bonus).stringValue;
//    NSInteger commaCount = (bonusString.length - 1) / 3;
//    CGFloat startPoint = ([UIScreen mainScreen].bounds.size.width - (14 * (bonusString.length + 1) + (bonusString.length + commaCount) * 3 + commaCount * 10)) / 2;
//    for (int i = 0; i < bonusString.length; i ++) {
//        UIButton *bonusBtn = [[UIButton alloc] initWithFrame:CGRectMake(startPoint, 0, 14, 20)];
//        [bonusBtn setBackgroundImage:[UIImage imageNamed:@"bg_lottery_money"] forState:UIControlStateNormal];
//        [bonusBtn setTitle:[bonusString substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateNormal];
//        [bonusBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//
//        if (0 == (bonusString.length - i) % 3 && i > 0) {
//            UIButton *commaBtn = [[UIButton alloc] initWithFrame:CGRectMake(startPoint, 0, 10, 20)];
//            [commaBtn setTitle:@"," forState:UIControlStateNormal];
//            [commaBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//            [bonusBtn setFrame:CGRectMake(startPoint + 13, 0, 14, 20)];
//            [self.bounctyView addSubview:commaBtn];
//            [self.bounctyView addSubview:bonusBtn];
//
//            startPoint += 32;
//        } else {
//            [self.bounctyView addSubview:bonusBtn];
//
//            startPoint += 17;
//        }
//    }
//
//    UIButton *suffixBtn = [[UIButton alloc] initWithFrame:CGRectMake(startPoint, 0, 14, 20)];
//    [suffixBtn setTitle:suffix forState:UIControlStateNormal];
//    [suffixBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    [self.bounctyView addSubview:suffixBtn];
//}

// 说明
- (void)Instruction {
    BetViewController *viewController = [[BetViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    ZPLog(@"说明");
}
// 历史开奖
-(void)HistoryLottery {
    ZP_InstructionController * Instruction = [[ZP_InstructionController alloc]init];
    [self.navigationController pushViewController:Instruction animated:YES];
    ZPLog(@"历史");
}
// 历史下注
- (IBAction)History:(UIButton *)sender {
    ZP_HistoryVetController * History = [[ZP_HistoryVetController alloc]init];
    [self.navigationController pushViewController:History animated:YES];
}

#pragma mark --tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * LotteryID = @"ZP_LotteryViewCell";
    ZP_LotteryViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LotteryID];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选中%ld",(long)indexPath.item);
}
@end
