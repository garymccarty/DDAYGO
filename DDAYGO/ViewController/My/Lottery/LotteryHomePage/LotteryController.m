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

@end

@implementation LotteryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initUI];
    self.title = NSLocalizedString(@"赏金彩", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
    self.titleArray = @[@"奖项",@"对中奖号数",@"本期各奖项金额",@"中奖数",@"赏金金额"];
}

- (CGSize)getStringSize:(NSString *)string FontSize:(NSInteger)fontSize Size:(CGSize)size {
    CGSize size1;
    CGSize widthSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:fontSize]} context:nil].size;
    size1.width = widthSize.width+1;
    size1.height = widthSize.height+1;
    return size1;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    CGFloat onScrollViewWidth = 0;
    for (int i = 0; i < self.titleArray.count; i ++) {
        switch (i) {
            case 0:
            {
                self.prizeWidth.constant = [self getStringSize:self.prizeLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
                onScrollViewWidth += self.prizeWidth.constant;
            }
                break;
            case 1:
            {
                self.winningNumbWidth.constant = [self getStringSize:self.winningNumbLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
                onScrollViewWidth += self.winningNumbWidth.constant;
            }
                break;
            case 2:
            {
                self.currentPeriodWidth.constant = [self getStringSize:self.currentPeriodLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
                onScrollViewWidth += self.currentPeriodWidth.constant;
            }
                break;
            case 3:
            {
                self.winnersNumWidth.constant = [self getStringSize:self.winnersNumLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
                onScrollViewWidth += self.winnersNumWidth.constant;
            }
                break;
            case 4:
            {
                self.bountyWidth.constant = [self getStringSize:self.bountyLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
                onScrollViewWidth += self.bountyWidth.constant;
            }
                break;
                
            default:
                break;
        }
    }
    
    self.onScrollViewWidth.constant = onScrollViewWidth;
}

- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_LotteryViewCell" bundle:nil] forCellReuseIdentifier:@"ZP_LotteryViewCell"];
    
    UIToolbar * tools=[[UIToolbar alloc]initWithFrame:CGRectMake(5, 0, 80, 39)];
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
    
//        UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bg_lottery_record"] style:UIBarButtonItemStylePlain target:self action:@selector(Instruction)];
//        self.navigationItem.rightBarButtonItem = item;
///**** IOS 11 ****/
//    if (@available(iOS 11.0, *)) {
//        self.bottomCV.estimatedRowHeight = 0;
//        self.bottomCV.estimatedSectionHeaderHeight = 0;
//        self.bottomCV.estimatedSectionFooterHeight = 0;
//    }
}
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
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZP_LotteryViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_LotteryViewCell"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选中%ld",(long)indexPath.item);
}
@end
