//
//  Supplier1ViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "Supplier1ViewController.h"
#import "PrefixHeader.pch"
#import "SupplierTableViewCell.h"
#import "SupplierViewCell2.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface Supplier1ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)NSArray * array;
@property (nonatomic, strong)NSArray * postionArray;

@property (nonatomic, strong) NSString *seleStr;
@property (nonatomic, strong) NSMutableArray *typeNameArray;
@property (nonatomic, strong) NSMutableArray *typeIdArray;


@end

@implementation Supplier1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self SupplierllData];
}

// UI
-(void)initUI {
    self.title = NSLocalizedString(@"供货商", nil);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色

    [self.tableView registerNib:[UINib nibWithNibName:@"SupplierTableViewCell" bundle:nil] forCellReuseIdentifier:@"SupplierTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SupplierViewCell2" bundle:nil] forCellReuseIdentifier:@"SupplierViewCell2"];
    
     _array = [NSArray arrayWithObjects:@"公司名稱:",@"統一編號:",@"公司人數:",@"註冊資本:",@"創立日期:",@"組織形態:",@"公司地址:",@"公司電話:",@"公司傳真(選填):",@"公司網址(選填):",@"聯繫人:",@"聯繫電話:",@"經營項目:",@"合作項目:", nil];
}
// 提交按钮
- (IBAction)SubmitBut:(id)sender {
    
    
    //这里就是你需要的所以数据· 自己填上 提交就知道了
    for (int i = 0; i < _array.count; i ++) {
        SupplierTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (i == 5) {
              NSLog(@"%@",_seleStr);
        }else{
            NSLog(@"textf = %@",cell.textField.text);
        }

    }
    
   NSString * a = @"199311";
   NSString * nwqa = [NSString stringWithFormat: @"-%@",a]; //----> newa  是不是  -199311
    
    
    [self AllData];
}

// 数据
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
//    dic[@"companyname"] = @"测试测试";
//    dic[@"companycode"] = @"51155455454";
//    dic[@"poeplecount"] = @"100人";
//    dic[@"capital"] = @"100万";
//    dic[@"companydate"] = @"20171001";
//    dic[@"companytype"] = @"1";
//    dic[@"address"] = @"公司地址公司地址公司地址公司地址";
//    dic[@"phone"] = @"141414414441441";
//    dic[@"fax"] = @"4545554545";
//    dic[@"companyuri"] = @"www.iii.com";
//    dic[@"contact"] = @"张鹏";
//    dic[@"contactphone"] = @"16161661616";
//    dic[@"contactemail"] = @"110@qq.com";
//    dic[@"companyproduct"] = @"你好吗";
//    dic[@"projectinfo"] = @"你好你好";
    [ZP_MyTool requestSupplierRequest:dic success:^(id obj) {
        ZPLog(@"%@",obj);
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (5 == indexPath.row) {
        SupplierViewCell2 * cell2 = [tableView dequeueReusableCellWithIdentifier:@"SupplierViewCell2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
        
        if (_seleStr.length > 0) {
            cell2.TissueMorphologyLabel.text = _seleStr;
        }else{
            cell2.TissueMorphologyLabel.text = @"请选择组织形态";
            
        }
        [cell2.SelectBut addTarget:self action:@selector(actBut:) forControlEvents:UIControlEventTouchUpInside];
        return cell2;
    }else {
        SupplierTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SupplierTableViewCell"];

        cell.titleLabel.text = self.array[indexPath.row];
        if (indexPath.row == 1) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            return cell;
            
        }
        if (indexPath.row == 2) {
            cell.textField.placeholder = NSLocalizedString(@"如:50 - 100 人", nil);
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            return cell;
        }
        if (indexPath.row == 3) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            return cell;
        }
        if (indexPath.row == 4) {
            cell.textField.placeholder = NSLocalizedString(@"yyyy-MM-dd", nil);
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            return cell;
        }
        if (indexPath.row == 7) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            return cell;
        }
        if (indexPath.row == 8) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            return cell;
        }
        
        if (indexPath.row == 10) {
            cell.textField.placeholder = NSLocalizedString(@"聯繫人/職稱/分機", nil);
            return cell;
        }
        
        return cell;
        
    }
}

// 获取组织形态列表
- (void)SupplierllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"countrycode"] = @"886";
    [ZP_MyTool requestCompanyType:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSArray *ar = obj;
        [ar enumerateObjectsUsingBlock:^(id  _Nonnull objj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.typeIdArray addObject:objj[@"typeid"]];
            [self.typeNameArray addObject:objj[@"typename"]];
        }];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
    
}

- (void)actBut:(UIButton *)but{
    
    
    JXPopoverView *popoverView = [JXPopoverView popoverView];
    NSMutableArray *titleArray = [NSMutableArray array];
    for (int i = 0; i < self.typeNameArray.count; i ++) {
        JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:self.typeNameArray[i] handler:^(JXPopoverAction *action) {
            
            NSLog(@"dian ji l %@",self.typeNameArray[i]);
           
            _seleStr = self.typeNameArray[i];
            NSIndexPath *index = [NSIndexPath indexPathForRow:5 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
            
                }];
        [titleArray addObject:action1];
    }

    [popoverView showToView:but withActions:titleArray];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (NSMutableArray *)typeIdArray
{
    if (!_typeIdArray) {
        _typeIdArray = [NSMutableArray array];
    }
    return _typeIdArray;
}
- (NSMutableArray *)typeNameArray
{
    if (!_typeNameArray) {
        _typeNameArray = [NSMutableArray array];
    }
    return _typeNameArray;
}

@end
