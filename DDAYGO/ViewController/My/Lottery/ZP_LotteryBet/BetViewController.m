//
//  BetViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetViewController.h"
#import "PrefixHeader.pch"
#import "tableHeadView1.h"
#import "ZP_MyTool.h"
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

@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) BetTableViewCellTwo *cell1;
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

//     添加一个按钮
    CGRect frame = _chooseCityBtn.frame;
    frame.size.width = 50;
    frame.size.height = 35;
    _chooseCityBtn.frame = frame;
    _chooseCityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
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
}


- (void)viewDidAppear:(BOOL)animated {
    self.tableView.frame =CGRectMake(0, 0, ZP_Width, ZP_height-TabbarHeight -NavBarHeight);
    
}

// 下注
- (void)Instruction {
    [self AllData];
}
// 下注
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"]  = Token;
    dic[@"count"] =_dicArray;
    dic[@"count"] = @"3";
    [ZP_MyTool requestBte:dic uccess:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"time_err"]) {
            [SVProgressHUD showInfoWithStatus:@"还没到开放时间"];
        }
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}
// 表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        self.tableHeadView1 = [[[NSBundle mainBundle] loadNibNamed:@"tableHeadView1" owner:nil options:nil] firstObject];
         self.tableHeadView1.BallLabel.text  = [NSString stringWithFormat:@"%ld",self.array1.count];
        return self.tableHeadView1;
    }
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 44)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 65, 44)];
        label.text = @"红球：1个,";
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 30, 44)];
        label2.text = @"已选";
        label2.font = [UIFont systemFontOfSize:13];
        [view addSubview:label2];
        _label3 = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 10, 44)];
        _label3.text  = [NSString stringWithFormat:@"%ld",self.arrayT.count];
        [_label3 setTextColor:[UIColor redColor]];
        _label3.font = [UIFont systemFontOfSize:13];
        [view addSubview:_label3];
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 15, 44)];
        label4.text = @"个";
        label4.font = [UIFont systemFontOfSize:13];
        [view addSubview:label4];
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
//        NSLog(@"you go");
        cell.butArray = self.array1;
        [cell upDataButtonWith:59];
        cell.arrayBlock = ^(NSMutableArray *arr1) {
           self.tableHeadView1.BallLabel.text = [NSString stringWithFormat:@"%ld",arr1.count];
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
            if (_dicArray.count >0) {
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
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
            _label3.text = [NSString stringWithFormat:@"%ld",arr2.count];
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
            if (_dicArray.count > 0) {
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
        };
        return cell;
     }else{
          _cell1 = [tableView dequeueReusableCellWithIdentifier:@"BetTableViewCellTwo" forIndexPath:indexPath];
         if (self.dicArray.count > 0) {
             

             if (indexPath.row == self.dicArray.count) {
                 [_cell1 updateCount:self.Selearray];
             }else{
                 NSMutableArray  *arr = [NSMutableArray arrayWithArray:self.dicArray[indexPath.row]];
                 _cell1.shuliangLabel.text = arr[6];
                 [arr removeObjectAtIndex:6];
                 [_cell1 updateCount:arr];
             }
         }else{
                 [_cell1 updateCount:self.Selearray];
         }
         _cell1.deleBut.tag = indexPath.row;
         [_cell1.deleBut addTarget:self action:@selector(dele:) forControlEvents:UIControlEventTouchUpInside];
         [_cell1.jiaBut addTarget:self action:@selector(jia:) forControlEvents:UIControlEventTouchUpInside];
         [_cell1.jianBut addTarget:self action:@selector(jian:) forControlEvents:UIControlEventTouchUpInside];
        return _cell1;
    }

}

- (void)jia:(UIButton *)but
{
    NSArray *arr = self.dicArray[but.tag];
    NSString *str = arr[6];
    
    if ([str integerValue] == 20) {
        [SVProgressHUD showInfoWithStatus:@"最高不能多于20注"];
        NSLog(@"20");
        return;
    }
    [self.dicArray[but.tag] removeObjectAtIndex:6];
    NSString *jStr = [NSString stringWithFormat:@"%d",[str integerValue] + 1];
    [self.dicArray[but.tag] addObject:jStr];
    NSIndexPath *index = [NSIndexPath indexPathForRow:but.tag inSection:2];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
 
}

- (void)jian:(UIButton *)but {

    NSArray *arr = self.dicArray[but.tag];
    NSString *str = arr[6];
    
    if ([str integerValue] == 1) {
        [SVProgressHUD showInfoWithStatus:@"最低不能少于1注"];
        NSLog(@"1");
        return;
    }
    [self.dicArray[but.tag] removeObjectAtIndex:6];
    NSString *jStr = [NSString stringWithFormat:@"%d",[str integerValue] - 1];
    [self.dicArray[but.tag] addObject:jStr];

    NSIndexPath *index = [NSIndexPath indexPathForRow:but.tag inSection:2];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
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

- (void)dele:(UIButton *)but {
    if (self.dicArray.count > 0 ) {
        if (but.tag == self.dicArray.count) {
            if (self.Selearray.count > 0) {
                [self.Selearray removeLastObject];
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                NSLog(@"没有选定 ");
                [SVProgressHUD showInfoWithStatus:@"没有选定"];
            }
        }else{
            [self.dicArray removeObjectAtIndex:but.tag];
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            if (self.dicArray.count > 0) {
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                [self.tableView reloadData];
            }
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
//    self.tableHeadView1.BallLabel.text  = [NSString stringWithFormat:@"%ld",self.array1.count];
    int a = arc4random_uniform(26);
     self.arrayT = [NSMutableArray array];
    [self.arrayT addObject:[NSNumber numberWithInt:a+ 100]];
//    _label3.text  = [NSString stringWithFormat:@"%ld",self.arrayT.count];
    self.Selearray = [NSMutableArray arrayWithArray:self.array1];
    [self.Selearray addObject:[NSNumber numberWithInt:a+100]];
    [self.tableView reloadData];
    
}

// 确定
- (IBAction)sureBut:(id)sender {
    
    NSLog(@"everyall %@  all %@  bai %@  hong zhe%@",self.Selearray,self.dicArray,self.array1,self.arrayT);

    if (self.array1.count < 5) {
//        tishi
        [SVProgressHUD showInfoWithStatus:@"请选择五个白球"];
        return;
    }
    if (self.arrayT.count < 1) {
        //tishi
        [SVProgressHUD showInfoWithStatus:@"请选择一个红球"];
        return;
    }
    if (self.Selearray.count< 6) {
        //
        [SVProgressHUD showInfoWithStatus:@"请选择五个白球与一个红球"];
        return;
    }

#pragma make -- 提示框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"确定选择该组号码吗？",nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ZPLog(@"取消");
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//        响应事件
        if (self.Selearray.count == 6) {
            [self.Selearray addObject:@"1"];
            [self.dicArray addObject:self.Selearray];
    
            self.array1 = nil;
            self.arrayT = nil;
            self.Selearray = nil;
            [self.tableView reloadData];
        }
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
//    }
}

- (NSMutableArray *)Selearray {
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

