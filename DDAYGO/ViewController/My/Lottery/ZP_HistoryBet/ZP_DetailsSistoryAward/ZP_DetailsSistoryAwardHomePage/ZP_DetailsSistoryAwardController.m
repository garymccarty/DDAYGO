//
//  ZP_DetailsSistoryAwardController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_DetailsSistoryAwardController.h"
#import "ZP_DetailsSistoryAwardTableViewCell.h"
#import "PrefixHeader.pch"
@interface ZP_DetailsSistoryAwardController ()<UITableViewDelegate, UITableViewDataSource>
//@property (strong, nonatomic) IBOutlet UITableView * tableView;

@property (nonatomic, strong) NSArray * titleArray;

@end

@implementation ZP_DetailsSistoryAwardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
}

- (void)initUI {
    
    self.title = NSLocalizedString(@"第2017135期", nil);
//    self.titleArray = @[@"奖项",@"对中奖号数",@"本期各奖项金额",@"中奖数",@"赏金金额"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    static NSString * DetailsSistoryAwardID = @"ZP_DetailsSistoryAwardTableViewCell";
    [self.tableview registerNib:[UINib nibWithNibName:@"ZP_DetailsSistoryAwardTableViewCell" bundle:nil] forCellReuseIdentifier:DetailsSistoryAwardID];
}

- (CGSize)getStringSize:(NSString *)string FontSize:(NSInteger)fontSize Size:(CGSize)size {
    CGSize size1;
    CGSize widthSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    size1.width = widthSize.width + 1;
    size1.height = widthSize.height + 1;
    return size1;
}
//- (void)updateViewConstraints {
//    [super updateViewConstraints];
//    CGFloat onScrollViewWidth = 0;
//    for (int i = 0; i < self.titleArray.count; i ++) {
//        switch (i) {
//            case 0:
//                {
//                    self.prizeWidth.constant = [self getStringSize:self.prizeLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
//                    onScrollViewWidth += self.prizeWidth.constant;
//                }
//                break;
//            case 1:
//            {
//                self.winningNumbWidth.constant = [self getStringSize:self.winningNumbLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
//                onScrollViewWidth += self.winningNumbWidth.constant;
//            }
//                break;
//            case 2:
//            {
//                self.currentPeriodWidth.constant = [self getStringSize:self.currentPeriodLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
//                onScrollViewWidth += self.currentPeriodWidth.constant;
//            }
//                break;
//            case 3:
//            {
//                self.winnersNumWidth.constant = [self getStringSize:self.winnersNumLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
//                onScrollViewWidth += self.winnersNumWidth.constant;
//            }
//                break;
//            case 4:
//            {
//                self.bountyWidth.constant = [self getStringSize:self.bountyLabel.text FontSize:13 Size:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 16;
//                onScrollViewWidth += self.bountyWidth.constant;
//            }
//                break;
//            default:
//                break;
//        }
//    }
//    self.onScrollViewWidth.constant = onScrollViewWidth;
//}

#pragma mark -- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * DetailsSistoryAwardID = @"ZP_DetailsSistoryAwardTableViewCell";
        ZP_DetailsSistoryAwardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DetailsSistoryAwardID];
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZPLog(@"%ld",indexPath.row);
}

@end
