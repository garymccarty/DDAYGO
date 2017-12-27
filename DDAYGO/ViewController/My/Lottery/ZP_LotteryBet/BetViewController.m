//
//  BetViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetViewController.h"
//#import "BetHeaderView.h"
#import "PrefixHeader.pch"
//#import "BetTableViewCell.h"
//#import "BetTwoTVCell.h"
#import "tableHeadView1.h"

#import "BetTableViewCellTwo.h"
#import "BetTableViewMyCell.h"
#import "BetTableViewMyCell2.h"

@interface BetViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UIButton * _chooseCityBtn;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic ,strong) BetHeaderView *whiteBallHeaderView;
//@property (nonatomic ,strong) BetHeaderView *redBallHeaderView;
@property (nonatomic,strong) tableHeadView1   *tableHeadView1;


//* 数据**/
@property (nonatomic, strong) NSMutableArray *Selearray;

@property (nonatomic,strong) NSMutableArray   *array1;
@property (nonatomic,strong) NSMutableArray   *arrayT;

@property (nonatomic, strong) NSMutableArray *dicArray;

@end

@implementation BetViewController

- (NSMutableArray *)dicArray
{
    if (!_dicArray) {
        _dicArray = [NSMutableArray array];
    }
    return _dicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"促销彩下注";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:@"BetTableViewMyCell" bundle:nil] forCellReuseIdentifier:@"BetTableViewMyCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BetTableViewCellTwo" bundle:nil] forCellReuseIdentifier:@"BetTableViewCellTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BetTableViewMyCell2" bundle:nil] forCellReuseIdentifier:@"BetTableViewMyCell2"];

    
    CGRect frame = _chooseCityBtn.frame;
    frame.size.width = 50;
    frame.size.height = 35;
    _chooseCityBtn.frame = frame;
    _chooseCityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [_chooseCityBtn setImage:[UIImage imageNamed:@"ic_home_down"] forState:(UIControlStateNormal)];
    [_chooseCityBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
    CGFloat imageWidth = _chooseCityBtn.imageView.bounds.size.width;
    CGFloat labelWidth = _chooseCityBtn.titleLabel.bounds.size.width;

    _chooseCityBtn.frame =CGRectMake(0, 0, 40.0f, 25.0f);
    _chooseCityBtn.titleLabel.font = ZP_TooBarFont;
    _chooseCityBtn.layer.cornerRadius = 3;
    _chooseCityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth   , 0, -labelWidth);
    _chooseCityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
    [_chooseCityBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _chooseCityBtn.backgroundColor = [UIColor whiteColor];
    [_chooseCityBtn addTarget:self action:@selector(Instruction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:_chooseCityBtn]];
    
    
//    //  添加两个button
//    NSMutableArray * buttons = [[NSMutableArray alloc]initWithCapacity:1];
//
//    UIBarButtonItem * Instruction = [[UIBarButtonItem alloc]initWithTitle:@"下注" style:UIBarButtonItemStyleDone target:self action:@selector(Instruction)];
//    Instruction.tintColor=[UIColor whiteColor];
//    [buttons addObject:Instruction];
//    [tools setItems:buttons animated:NO];
//    UIBarButtonItem * btn =[[UIBarButtonItem alloc]initWithCustomView:tools];
//    self.navigationItem.rightBarButtonItem = btn;
//    __weak BetViewController *controller = self;
//    [self addNavigationBarItemWithType:LLNavigationBarItemTypeRightFirst handler:^(UIButton *button) {
//
//        [button setTitle:NSLocalizedString( @"提交", nil) forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor whiteColor];
//        [button addTarget:controller action:@selector(Instruction) forControlEvents:UIControlEventTouchUpInside];
//
//        CGRect frame = button.frame;
//        frame.size.width = 50;
//        button.frame = frame;
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(controller.view).offset(10);
//            make.bottom.equalTo(controller.view).offset(8);
//            make.width.mas_offset(10);
//            make.height.mas_offset(15);
//        }];
//    }];
}


- (void)viewDidAppear:(BOOL)animated {
    self.tableView.frame =CGRectMake(0, 0, ZP_Width, ZP_height-TabbarHeight -NavBarHeight);
    
}

// 下注
- (void)Instruction {
    
    ZPLog(@"下注");
}
// 下注
- (void)AllData {
    
}
// 表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        self.tableHeadView1 = [[[NSBundle mainBundle] loadNibNamed:@"tableHeadView1" owner:nil options:nil] firstObject];
        return self.tableHeadView1;
    }
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 44)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 44)];
        label.text = @"红球：1个，已选 1 个";
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 44)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 44)];
        label.text = @"选定的号码";
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        return view;
    }
}

//  设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 120.0f;
    }else{
        return 44.0f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dicArray.count > 0) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //这个+1
    if (section == 2) {
        return self.dicArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        BetTableViewMyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BetTableViewMyCell"];
        NSLog(@"you go");
        cell.butArray = self.array1;
        [cell upDataButtonWith:59];
        cell.arrayBlock = ^(NSMutableArray *arr1) {
            
            if (self.Selearray.count > 0) {
                for (NSNumber *Nstr in self.Selearray) {
                    if ([Nstr integerValue] > 99) {
                        self.Selearray = [NSMutableArray arrayWithArray:arr1];
                        [self.Selearray addObject:Nstr];
                        break;
                    }else{
                        self.Selearray = [NSMutableArray arrayWithArray:arr1];
                    }
                }
            }else{
                self.Selearray = [NSMutableArray arrayWithArray:arr1];
            }
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        return cell;
    }else
     if(indexPath.section == 1) {
        NSLog(@"who go");
        BetTableViewMyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"BetTableViewMyCell2"];
        NSLog(@"you go");
         cell.butArray = self.arrayT;
        [cell upDataButtonWith:26];
        cell.arrayBlock = ^(NSMutableArray *arr2) {
            _arrayT = arr2;
            if (arr2.count == 0) {
                [self.Selearray removeLastObject];
            }else{
                if (self.Selearray.count > 0) {
                    for (NSNumber *Nstr in self.Selearray) {
                        if ([Nstr integerValue] < 99) {
                            [self.Selearray addObject:arr2[0]];
                            break;
                        }else{
                            self.Selearray = [NSMutableArray arrayWithArray:arr2];
                        }
                    }
                }else{
                    self.Selearray = [NSMutableArray arrayWithArray:arr2];
                }
            }
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            

        };
        return cell;
     }else{
          BetTableViewCellTwo *cell1 = [tableView dequeueReusableCellWithIdentifier:@"BetTableViewCellTwo" forIndexPath:indexPath];
         if (self.dicArray.count > 0) {             
             if (indexPath.row == self.dicArray.count) {
                 [cell1 updateCount:self.Selearray];
             }else{
                 NSArray *arr = self.dicArray[indexPath.row];
                 [cell1 updateCount:arr];
             }
         }else{
                 [cell1 updateCount:self.Selearray];
         }
         cell1.deleBut.tag = indexPath.row;
         [cell1.deleBut addTarget:self action:@selector(dele:) forControlEvents:UIControlEventTouchUpInside];
        return cell1;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 59 / 8 * [UIScreen mainScreen].bounds.size.width/8 + 40;
    }
    if (indexPath.section == 1) {
        return 26 / 8 * [UIScreen mainScreen].bounds.size.width/8 + 40;
    }else{
        return 35;
    }
    
}


- (void)dele:(UIButton *)but
{
    if (self.dicArray.count > 0 ) {
        if (but.tag == self.dicArray.count) {
            if (self.Selearray.count > 0) {
                [self.Selearray removeLastObject];
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                NSLog(@"没有选定 ");
                [SVProgressHUD showErrorWithStatus:@"没有选定"];
            }
        }else{
            [self.dicArray removeObjectAtIndex:but.tag];
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [self.tableView reloadData];
        }
    }
    
}
// 机选
- (IBAction)suijiBut:(id)sender {
    self.array1 = [NSMutableArray array];
    for (int i = 0; i< 5; i++) {
        int i = arc4random_uniform(59);
        [self.array1 addObject:[NSNumber numberWithInt:i]];
    }
    int a = arc4random_uniform(26)+100;
     self.arrayT = [NSMutableArray array];
    [self.arrayT addObject:[NSNumber numberWithInt:a]];
    
    self.Selearray = [NSMutableArray arrayWithArray:self.array1];
    [self.Selearray addObject:[NSNumber numberWithInt:a]];
    
}
// 确定
- (IBAction)sureBut:(id)sender {
    if (self.Selearray.count == 6) {
        [self.dicArray addObject:self.Selearray];
        NSLog(@"%ld - %@",self.dicArray.count ,self.dicArray);
        self.array1 = nil;
        self.arrayT = nil;
        self.Selearray = nil;
        [self.tableView reloadData];
    }
}

- (NSMutableArray *)Selearray
{
    if (!_Selearray) {
        _Selearray = [NSMutableArray array];
    }
    return _Selearray;
}

- (NSMutableArray *)array1
{
    if (!_array1) {
        _array1 = [NSMutableArray array];
    }
    return _array1;
}

- (NSMutableArray *)arrayT
{
    if (!_arrayT) {
        _arrayT = [NSMutableArray array];
    }
    return _arrayT;
}
@end

