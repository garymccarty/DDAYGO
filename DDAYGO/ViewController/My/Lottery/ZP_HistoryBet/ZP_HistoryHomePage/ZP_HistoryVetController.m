//
//  ZP_HistoryVetController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_HistoryVetController.h"
#import "ZP_HistoryBetCell.h"
#import "ZP_DetailsSistoryAwardController.h"
#import "PrefixHeader.pch"
@interface ZP_HistoryVetController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation ZP_HistoryVetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI {
    
    self.title = NSLocalizedString(@"历史下注", nil);
//    static NSString * ZP_HistoryID = @"ZP_HistoryBetCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_HistoryBetCell" bundle:nil] forCellReuseIdentifier:@"ZP_HistoryBetCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    self.tableView.backgroundColor = [UIColor grayColor];
/**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
}

///*设置标题头的宽度*/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 60;
    }else
        if (section == 3) {
            return  60;
        }
    
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 60)];
        ZP_GeneralLabel * numberingLabel = [ZP_GeneralLabel initWithtextLabel:_numberingLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
        numberingLabel.frame = CGRectMake(0, 0, ZP_Width, 30);
        numberingLabel.text = @"第2017136期";
        [v1 addSubview:numberingLabel];
        ZP_GeneralLabel * numberingLabel2 = [ZP_GeneralLabel initWithtextLabel:_numberingLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
        numberingLabel2.frame = CGRectMake(0, 30, ZP_Width, 30);
        numberingLabel2.text = @"订单号：1234453454";
        numberingLabel2.backgroundColor = [UIColor whiteColor];
        [v1 addSubview:numberingLabel2];
        
        return v1;
    }
    else if (section == 1) {
        ZP_GeneralLabel * numberingLabel = [ZP_GeneralLabel initWithtextLabel:_numberingLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
        numberingLabel.backgroundColor = [UIColor grayColor];
        numberingLabel.frame = CGRectMake(0, 0, ZP_Width, 30);
        numberingLabel.text = @"didanhao";
        return numberingLabel;
    }
    else if (section == 2) {
        ZP_GeneralLabel * numberingLabel = [ZP_GeneralLabel initWithtextLabel:_numberingLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
        numberingLabel.frame = CGRectMake(0, 0, ZP_Width, 30);
        numberingLabel.text = @"地单号";
        return numberingLabel;
    }
    else{
        UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 60)];
        ZP_GeneralLabel * numberingLabel = [ZP_GeneralLabel initWithtextLabel:_numberingLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
        numberingLabel.frame = CGRectMake(0, 0, ZP_Width, 30);
        numberingLabel.text = @"第2017136期";
        [v2 addSubview:numberingLabel];
        ZP_GeneralLabel * numberingLabel2 = [ZP_GeneralLabel initWithtextLabel:_numberingLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
        numberingLabel2.frame = CGRectMake(0, 30, ZP_Width, 30);
        numberingLabel2.text = @"订单号：567890876";
        numberingLabel2.backgroundColor = [UIColor whiteColor];
        [v2 addSubview:numberingLabel2];
        
        return v2;
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            return 1;
        }break;
        case 1:{
            return 2;
        }break;
        case 2:{
            return 3;
        }break;
        case 3:{
            return 4;
        }break;
            
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_HistoryBetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_HistoryBetCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_DetailsSistoryAwardController * DetailsSistoryAward = [[ZP_DetailsSistoryAwardController alloc]init];
    [self.navigationController pushViewController:DetailsSistoryAward animated:YES];
    ZPLog(@"%ld",indexPath.row);
}
@end
