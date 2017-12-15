//
//  BetViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetViewController.h"
#import "BetHeaderView.h"
#import "PrefixHeader.pch"
#import "BetTableViewCell.h"
#import "BetTwoTVCell.h"
@interface BetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) BetHeaderView *whiteBallHeaderView;
@property (nonatomic ,strong) BetHeaderView *redBallHeaderView;

@end

@implementation BetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"促销彩下注";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"BetTableViewCell" bundle:nil] forCellReuseIdentifier:@"BetTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BetTwoTVCell" bundle:nil] forCellReuseIdentifier:@"BetTwoTVCell"];

    
    
//    self.whiteBallHeaderView = [[NSBundle mainBundle] loadNibNamed:@"BetHeaderView" owner:self options:nil].lastObject;
//    self.redBallHeaderView   = [[NSBundle mainBundle] loadNibNamed:@"BetHeaderView" owner:self options:nil].lastObject;
    UIToolbar * tools = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 0, 15)];
    // 解决出现的那条线
    tools.clipsToBounds = YES;
    // 解决tools背景颜色的问题
    [tools setBackgroundImage:[UIImage new]forToolbarPosition:UIBarPositionAny                      barMetrics:UIBarMetricsDefault];
    [tools setShadowImage:[UIImage new]
       forToolbarPosition:UIToolbarPositionAny];
    //  添加两个button
    NSMutableArray * buttons = [[NSMutableArray alloc]initWithCapacity:1];
    
//    UIBarButtonItem * Instruction = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bg_lottery_record"] style: UIBarButtonItemStyleDone target:self action:@selector(Instruction)];
    UIBarButtonItem * Instruction = [[UIBarButtonItem alloc]initWithTitle:@"下注" style:UIBarButtonItemStyleDone target:self action:@selector(Instruction)];
    Instruction.tintColor=[UIColor whiteColor];
    [buttons addObject:Instruction];
    [tools setItems:buttons animated:NO];
    UIBarButtonItem * btn =[[UIBarButtonItem alloc]initWithCustomView:tools];
    self.navigationItem.rightBarButtonItem = btn;
}

// 下注
- (void)Instruction {

    ZPLog(@"下注");
}





// 表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *myView = [[UIView alloc]init];
    self.tableView.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_Graybackground];
//     标题1
    ZP_GeneralLabel * TitleLabel1 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel1.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    TitleLabel1.text = @"距2014137期截止:";
    [myView addSubview:TitleLabel1];
    _TitleLabel1 = TitleLabel1;
    [TitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(55);
        make.top.equalTo(myView).offset(5);
//        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
//     标题2
    ZP_GeneralLabel * TitleLabel2 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel2.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    TitleLabel2.text = @"奖池:";
    [myView addSubview:TitleLabel2];
    _TitleLabel2 = TitleLabel2;
    [TitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(80);
        make.top.equalTo(myView).offset(20);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
//    时间
    ZP_GeneralLabel * TimeLabel = [ZP_GeneralLabel initWithtextLabel:_TimeLabel.text textColor:[UIColor redColor] font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    TimeLabel.text = @"16天22小时45分";
    [myView addSubview:TimeLabel];
    _TimeLabel = TimeLabel;
    [TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TitleLabel1).offset(90);
        make.top.equalTo(TitleLabel1).offset(0);
        make.height.mas_offset(15);
    }];
//  金额
    ZP_GeneralLabel * AmountLabel = [ZP_GeneralLabel initWithtextLabel:_AmountLabel.text textColor:[UIColor redColor] font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    AmountLabel.text = @"￥165,973,926";
    [myView addSubview:AmountLabel];
    _AmountLabel = AmountLabel;
    [AmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TitleLabel2).offset(25);
        make.top.equalTo(TitleLabel2).offset(0);
        make.height.mas_offset(15);
    }];

//    元
    ZP_GeneralLabel * YuanLabel = [ZP_GeneralLabel initWithtextLabel:_YuanLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    YuanLabel.text = @"元";
    [myView addSubview:YuanLabel];
    [YuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AmountLabel).offset(75);
        make.top.equalTo(AmountLabel).offset(0);
        make.height.mas_offset(15);
    }];
    
    return myView;
}

//  设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //这个+1
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BetTableViewCell"];
    if (indexPath.row == 0) {
        [cell.betHeaderView updateViewWithColor:DDWriteBet TotalCount:5 SelectedCount:1];
        [cell updateCount:59];
    }
   else if (indexPath.row == 1) {
        [cell.betHeaderView updateViewWithColor:DDRedBet TotalCount:1 SelectedCount:1];
        [cell updateCount:26];
    }
    else{
        BetTwoTVCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"BetTwoTVCell"];
        return cell1;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSInteger count = 0;
//    if (indexPath.row == 0) {
//        count = 59;
//    } else {
//        count = 26;
//    }
//    if (count % 8 == 0) {
//        return count / 8 * [UIScreen mainScreen].bounds.size.width/8 + 40;
//    } else {
//        return count / 8 * [UIScreen mainScreen].bounds.size.width/8 + 80;
//    }
    if (indexPath.row == 0) {
        return 59 / 8 * [UIScreen mainScreen].bounds.size.width/8 + 40;
    }
    if (indexPath.row == 1) {
        return 26 / 8 * [UIScreen mainScreen].bounds.size.width/8 + 80;
    }else{
        return 65;
    }

}

@end
