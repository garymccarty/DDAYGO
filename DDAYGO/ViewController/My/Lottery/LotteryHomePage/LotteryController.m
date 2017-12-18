//
//  LotteryController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LotteryController.h"
#import "PrefixHeader.pch"
#import "BetViewController.h"
#import "ZP_HistoryVetController.h"
#import "ZP_InstructionController.h"
#import "ZP_CheckMoreController.h"
#import "ZP_MyTool.h"
#import "ZP_LotterModel.h"
@interface LotteryController ()

@property (strong ,nonatomic) NSArray *titleArray;
@property (strong ,nonatomic) NSArray *titleLabelArray;
@property (strong ,nonatomic) NSArray *titleWidthArray;

@property (strong ,nonatomic) NSArray *prizeArray;
@property (strong ,nonatomic) NSArray *winningNumbArray;
@property (strong ,nonatomic) NSArray *currentPeriodArray;
@property (strong ,nonatomic) NSArray *winnersNumArray;
@property (strong ,nonatomic) NSArray *bountyArray;
@property (strong ,nonatomic) NSDictionary *prizeDic;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView * OrderNumView;
@end

@implementation LotteryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self getData];
}

- (void)getData {

    [ZP_MyTool getPrizeInfo:^(id obj) {
        //这个是一次的数据
        ZP_LotterModel * model = [ZP_LotterModel mj_objectWithKeyValues:obj];
        self.prizeDic = obj;
        [self updateData:model];
    } failure:^(NSError *error) {
        
    }];
}

- (void)updateData:(ZP_LotterModel *)model{
    
     lotteryModel *model1 = [lotteryModel mj_objectWithKeyValues:model.lottery];
    _AmountLabel.text = [model1.poolamount stringValue];
    _dateLabel.text = model1.createtime;
    [_but1 setTitle:[model1.white1 stringValue] forState:UIControlStateNormal];
    [_but2 setTitle:[model1.white2 stringValue] forState:UIControlStateNormal];
    [_but3 setTitle:[model1.white3 stringValue] forState:UIControlStateNormal];
    [_but4 setTitle:[model1.white4 stringValue] forState:UIControlStateNormal];
    [_but5 setTitle:[model1.white5 stringValue] forState:UIControlStateNormal];
    [_but6 setTitle:[model1.powerball stringValue] forState:UIControlStateNormal];
//    NSLog(@"dic %@",model.lottery);
    
    //下面一个数据 直接用
    lotteryModel *model2 = [lotteryModel mj_objectWithKeyValues:model.lottery];
    //        _AmountLabel.text = [model2.poolamount stringValue];
    NSLog(@"m2 %@",model2.createtime);
    // lottoerwinmodel 的数据
    NSArray *arr = [lotterywinModel mj_objectArrayWithKeyValuesArray:model.lotterywin];
    
    //如你想取第一个的数据
    lotterywinModel * model3 = arr[0]; //这个是头奖的后面
    _currentPeriodLabel1.text = [model3.winamount stringValue];
    _currentPeriodLabel2.text = [model3.wincount stringValue];
    _currentPeriodLabel3.text = [model3.winunit stringValue];
    _currentPeriodLabel4.text = [model3.winunit stringValue];
    _currentPeriodLabel5.text = [model3.winunit stringValue];
//    NSLog(@"m3 = %@",model3.state);
    //以此类推
    lotterywinModel *model4 = arr[1]; //这个是头奖的后面
    _winnersNumLabel1.text = [model4.winamount stringValue];
    _winnersNumLabel2.text = [model4.wincount stringValue];
    _winnersNumLabel3.text = [model4.winunit stringValue];
    _winnersNumLabel4.text = [model4.winunit stringValue];
    _winnersNumLabel5.text = [model4.winunit stringValue];
    
    lotterywinModel *model5 = arr[2]; //这个是头奖的后面
    _bountyLabel1.text = [model5.winamount stringValue];
    _bountyLabel2.text = [model5.wincount stringValue];
    _bountyLabel3.text = [model5.winunit stringValue];
    _bountyLabel4.text = [model5.winunit stringValue];
    _bountyLabel5.text = [model5.winunit stringValue];
    
    lotteryorderModel * model6 = [lotteryorderModel mj_objectWithKeyValues:model.lottery];
    _OrderNumberLabel.text = [model6.lotteryoid stringValue];
    [_butt1 setTitle:[model6.white1 stringValue] forState:UIControlStateNormal];
    [_butt2 setTitle:[model6.white2 stringValue] forState:UIControlStateNormal];
    [_butt3 setTitle:[model6.white3 stringValue] forState:UIControlStateNormal];
    [_butt4 setTitle:[model6.white4 stringValue] forState:UIControlStateNormal];
    [_butt5 setTitle:[model6.white5 stringValue] forState:UIControlStateNormal];
    [_butt6 setTitle:[model6.powerball stringValue] forState:UIControlStateNormal];
    NSLog(@"m3 = %@",model.lottery);
    
//    self.periodsLabel.text = [NSString stringWithFormat:@"第%@期",[self.prizeDic[@"lottery"][@"periods"] stringValue]];
//    self.dateLabel.text = self.prizeDic[@"lottery"][@"createtime"];
//    //$
    [self updateBounctyViewWithBonus:[self.prizeDic[@"lottery"][@"poolamount"] integerValue] Suffix:@"$"];
//
//    NSArray *prizeArray = self.prizeDic[@"lotterywin"];
//    for (int i = 0; i < prizeArray.count - 1; i ++) {
//        NSDictionary *tempDic = prizeArray[i];
//        UILabel * tempWinningNumbLabel = self.winningNumbArray[i];
//        UILabel * tempCurrentPeriodLabel = self.currentPeriodArray[i];
//        UILabel * tempWinnersNumLabel = self.winnersNumArray[i];
//        UILabel * tempBountyLabel = self.bountyArray[i];
//
//        tempWinningNumbLabel.text = [tempDic[@"state"] stringValue];
//        tempCurrentPeriodLabel.text = [tempDic[@"winamount"] stringValue];
//        tempWinnersNumLabel.text = [tempDic[@"wincount"] stringValue];
//        tempBountyLabel.text = [tempDic[@"winunit"] stringValue];
//    }
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
    
//    static NSString * LotteryID = @"ZP_LotteryViewCell";
//    [self.tableView registerNib:[UINib nibWithNibName:LotteryID bundle:nil] forCellReuseIdentifier:LotteryID];
//    self.tableView.separatorStyle = UITableViewRowAnimationNone; // 隐藏tableview线条
    
//    self.wirteBetCount = 6;
//    self.CCollectionView.delegate = self;
//    self.CCollectionView.dataSource = self;
//    static NSString * LotteryID = @"ZP_LotteryCollectionViewCell";
//    [self.CCollectionView registerNib:[UINib nibWithNibName:LotteryID bundle:nil] forCellWithReuseIdentifier:LotteryID];
    
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
    
    // 调这里 fame就好
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(20, CGRectGetMaxY(_OrderNumView.frame) + 10, ZP_Width - 40, 40);
    [but setTitle:@"下注" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(betAction) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:but];
    
    NSLog(@"%f",_OrderNumView.frame.origin.y);
    NSLog(@"%f",but.frame.origin.y);
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(20, CGRectGetMaxY(but.frame)+10, ZP_Width - 40, 40);
    [but2 setTitle:@"历史下注号码" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(HistoricalBetAction) forControlEvents:UIControlEventTouchUpInside];
    but2.backgroundColor = [UIColor orangeColor];
    [self.scrollView addSubview:but2];
    
    self.winningNumbArray = @[self.winningNumbLabel1,self.winningNumbLabel2,self.winningNumbLabel3,self.winningNumbLabel4];
    self.currentPeriodArray = @[self.currentPeriodLabel1,self.currentPeriodLabel2,self.currentPeriodLabel3,self.currentPeriodLabel4];
    self.winnersNumArray = @[self.winnersNumLabel1,self.winnersNumLabel2,self.winnersNumLabel3,self.winnersNumLabel4];
    self.bountyArray = @[self.bountyLabel1,self.bountyLabel2,self.bountyLabel3,self.bountyLabel4];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 上面的frame高度 于110> 10+ 40 + 10 +40
    //    //如果等于 就刚刚好在底部
    self.scrollView.contentSize = CGSizeMake(ZP_Width, CGRectGetMaxY(_OrderNumView.frame)+110);
}

// 下注
- (void)betAction {
    BetViewController *viewController = [[BetViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}
// 历史下注
- (void)HistoricalBetAction {
    ZPLog(@"&*(");
}

/*
#pragma mark -- Collectionview  delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.wirteBetCount;
}

- (void)updateCount:(NSInteger)count {
    self.wirteBetCount = count;
    [self.CCollectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(30, 30);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * LotteryID = @"ZP_LotteryCollectionViewCell";
    ZP_LotteryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LotteryID forIndexPath:indexPath];
    [cell setValue:indexPath.row + 1];
    return cell;
}
*/
#pragma mark  更新赏金视图
- (void)updateBounctyViewWithBonus:(NSInteger)bonus Suffix:(NSString *)suffix {
    for (UIView *view in self.bounctyView.subviews) {
        [view removeFromSuperview];
    }

    NSString *bonusString = @(bonus).stringValue;
    NSInteger commaCount = (bonusString.length - 1) / 3;
    CGFloat startPoint = ([UIScreen mainScreen].bounds.size.width - (14 * (bonusString.length + 1) + (bonusString.length + commaCount) * 3 + commaCount * 10)) / 2;
    for (int i = 0; i < bonusString.length; i ++) {
        UIButton *bonusBtn = [[UIButton alloc] initWithFrame:CGRectMake(startPoint, 0, 14, 20)];
        [bonusBtn setBackgroundImage:[UIImage imageNamed:@"bg_lottery_money"] forState:UIControlStateNormal];
        [bonusBtn setTitle:[bonusString substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateNormal];
        [bonusBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

        if (0 == (bonusString.length - i) % 3 && i > 0) {
            UIButton *commaBtn = [[UIButton alloc] initWithFrame:CGRectMake(startPoint, 0, 10, 20)];
            [commaBtn setTitle:@"," forState:UIControlStateNormal];
            [commaBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [bonusBtn setFrame:CGRectMake(startPoint + 13, 0, 14, 20)];
            [self.bounctyView addSubview:commaBtn];
            [self.bounctyView addSubview:bonusBtn];

            startPoint += 32;
        } else {
            [self.bounctyView addSubview:bonusBtn];

            startPoint += 17;
        }
    }

    UIButton *suffixBtn = [[UIButton alloc] initWithFrame:CGRectMake(startPoint, 0, 14, 20)];
    [suffixBtn setTitle:suffix forState:UIControlStateNormal];
    [suffixBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.bounctyView addSubview:suffixBtn];
}


// 说明
- (void)Instruction {
    ZP_InstructionController * Instruction = [[ZP_InstructionController alloc]init];
    [self.navigationController pushViewController:Instruction animated:YES];
    ZPLog(@"说明");
}
// 历史开奖
-(void)HistoryLottery {
    ZP_HistoryVetController * History = [[ZP_HistoryVetController alloc]init];
    [self.navigationController pushViewController:History animated:YES];
    ZPLog(@"历史");
}
// 历史下注
- (IBAction)History:(UIButton *)sender {
    ZP_HistoryVetController * History = [[ZP_HistoryVetController alloc]init];
    [self.navigationController pushViewController:History animated:YES];
}
// 查看更多
- (IBAction)CheckMore:(id)sender {
    ZP_CheckMoreController * CheckMore = [[ZP_CheckMoreController alloc]init];
    [self.navigationController pushViewController:CheckMore animated:YES];
}

//#pragma mark --tableview delegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString * LotteryID = @"ZP_LotteryViewCell";
//    ZP_LotteryViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LotteryID];
//
//    return cell;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 80;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    NSLog(@"选中%ld",(long)indexPath.item);
//}
@end
