//
//  MyViewController.m
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "MyViewController.h"
#import "UINavigationBar+Awesome.h"
#import "NewsViewController.h"
#import "ConcernShopViewController.h"
#import "CollectionViewController.h"
#import "FootprintViewController.h"
#import "SettingViewController.h"
#import "StoreViewController.h"
#import "QCodeController.h"
#import "LotteryController.h"
#import "LogregisterController.h"
#import "PrefixHeader.pch"
#import "Supplier1ViewController.h"
#import "ZP_MyTool.h"
#import "ZP_HomePageModel.h"
#import "ZP_LoginTool.h"
#import "ZP_MyHopageModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SDImageCache.h"
@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UIView * userBackView;
@property (weak, nonatomic) IBOutlet UIView * sdglView;
@property (weak, nonatomic) IBOutlet UIView * xfjlView;
//@property (weak, nonatomic) IBOutlet UIView * zxxxView;
@property (weak, nonatomic) IBOutlet UIView * scanView;
@property (weak, nonatomic) IBOutlet UIView * CaipiaoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SdglLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *XfjlLayoutConstraint;
@property (nonatomic, strong) NSString * reason;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
// 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self initUI];
    [self LoginJudde];
    [self loginAllData];
//    [self Supplier];
    
    //    本地数据调用
    UIImage * image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
    if (image) {
        _headImageBut.layer.cornerRadius = 42;
        _headImageBut.layer.masksToBounds = YES;
        [_headImageBut setImage:image forState:UIControlStateNormal];
    }
    
}

- (void) Supplier {
    //     判断是否是供货商
    if (state.length == NO) {
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
        //        _viewLayoutConstraint.constant = 50.0;
    }
    //     判断是否申请成功供货商
//    if (state.length == YES) {
//        //        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
//        self.XfjlLayoutConstraint.constant = CGFLOAT_MIN;
//        self.xfjlView.hidden = YES;
//        //        _viewLayoutConstraint.constant = 50.0;
//    }
}

// 登录状态
- (void)LoginJudde {
    [self autoLogin:^(id obj) {
        if (!DD_HASLOGIN) {
            if (![MyViewController sharedInstanceTool].hasRemind) {
                [MyViewController sharedInstanceTool].hasRemind = YES;
                LogregisterController *viewcontroller = [[LogregisterController alloc] init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewcontroller animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        } else {
            [self updateUserInfo];
        }
    }];
}
//
- (void)loginAllData {
    //    判断是否登录
    if (!Token) {
        if (![MyViewController sharedInstanceTool].hasRemind) {
            [MyViewController sharedInstanceTool].hasRemind = YES;
            LogregisterController *viewcontroller = [[LogregisterController alloc] init];
            [self.navigationController pushViewController:viewcontroller animated:YES];
        }
    }else {
        
        [self AllDatas];
        [self allData];
        [self SupplierAllData];
    }
}
+ (MyViewController *)sharedInstanceTool {
    static MyViewController *instance = nil;
    static NSString *language = nil;
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Language"]) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] setObject:array.firstObject forKey:@"Language"];
    }
    NSString *language1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Language"];
    if (!language) {
        language = [[NSUserDefaults standardUserDefaults] objectForKey:@"Language"];
    }
    if (!instance || ![language isEqualToString:language1]) {
        language = language1;
        instance = [[self alloc] init];
    }
    
    return instance;
}


- (void)autoLogin:(void (^)(id obj))success {
    if (DD_HASLOGIN) {
        if (success) {
            success(nil);
    }
    } else {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]) {
            NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"];
            [ZP_LoginTool requestLogin:dic success:^(id obj) {
                NSLog(@"obj---%@",obj);
                NSDictionary * dic = obj;
                [[NSUserDefaults standardUserDefaults] setObject:Token forKey:@"token"];
                
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            [ZP_LoginTool getAccountInfo:Token success:^(id obj) {
                NSDictionary * tempDic = obj;
                NSDictionary *asdic = @{@"address":tempDic[@"address"],@"aid":tempDic[@"aid"],@"avatarimg":tempDic[@"avatarimg"],@"countrycode":tempDic[@"countrycode"],@"email":tempDic[@"email"],@"nickname":tempDic[@"nickname"],@"phone":tempDic[@"phone"],@"realname":tempDic[@"realname"],@"sex":tempDic[@"sex"],@"state":tempDic[@"state"]};
                [[NSUserDefaults standardUserDefaults] setObject:asdic forKey:@"userInfo"];
//                DD_HASLOGIN = YES;
        if (success) {
             success(nil);
            }
        } failure:^(NSError *error) {
        if (success) {
            success(nil);
            }
            NSLog(@"%@",error);
         }];
        }
       } failure:^(NSError *error) {
        if (success) {
            success(nil);
        }
        NSLog(@"%@",error);
      }];
      } else {
          if (success) {
              success(nil);
            
            }
        }
    }
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.popKind == DDFromDataVC) {
        self.tabBarController.selectedIndex = 3;
        self.popKind = 0;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
    
}

//  个人资料
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    int i = arc4random_uniform(999);  // 随机数
    dic[@"nonce"] = @(i);
//    dic[@"nonce"] = @"adf";
    [ZP_MyTool requestSetHomePage:dic success:^(id obj) {
        ZPLog(@"%@",obj);
       // [self SupplierAllData];
        ZP_HomePageModel * model = [[ZP_HomePageModel alloc]init];
        model.nickname = obj[@"nickname"];
        model.avatarimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@",obj[@"avatarimg"]];
        [self.headImageBut sd_setBackgroundImageWithURL:[NSURL URLWithString:model.avatarimg] forState:UIControlStateNormal];
//        [self.headImageBut sd_setImageWithURL:[NSURL URLWithString:model.avatarimg]];
        [self MyViewData:model];
        
    } failure:^(NSError * error) {
        //        if (state.length == NO) {
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
        //        _viewLayoutConstraint.constant = 50.0;
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
//        }
    }];
}

- (void)MyViewData:(ZP_HomePageModel *) model {
    _NameLabel.text = model.nickname;
//    [self.headImageBut sd_setImageWithURL:[NSURL URLWithString:model.avatarimg] placeholderImage:[UIImage imageNamed:@"HeadrImage"]];
    
}

// 获取浏览记录、收藏的数量
- (void)AllDatas {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    [ZP_MyTool requesBrowseCollection:dic uccess:^(id obj) {
        ZPLog(@"%@",obj);
        ZP_MyHopageModel * model = [[ZP_MyHopageModel alloc]init];
        model.collecedcount = obj[@"collecedcount"];
        model.historycount = obj[@"historycount"];
        [self setAllDatas:model];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
        //        _viewLayoutConstraint.constant = 50.0;
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
//        [SVProgressHUD showInfoWithStatus:@"服務器連接失敗"];
    }];
}

- (void)setAllDatas:(ZP_MyHopageModel *)model {
    _CollectionLabel.text =  [NSString stringWithFormat:@"%@",model.collecedcount];
    _BrowseLabel.text = [NSString stringWithFormat:@"%@",model.historycount];
}

// 供货商状态请求
- (void) SupplierAllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    [ZP_MyTool requestSupplier:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        ZP_MyHopageModel2 * model = [[ZP_MyHopageModel2 alloc]init];
        model.state = obj[@"state"];
        self.RequestStatusStr = model.state;
        
        if ([obj[@"result"] isEqualToString:@"ok"]) {
            _RequestStatusStr = @(-1);
            _RequestStatusLabel.text = @"";
            _kuohaoLabel1.hidden = YES;
            _kuohaoLabel2.hidden = YES;
        }else{
            _kuohaoLabel1.hidden = NO;
            _kuohaoLabel2.hidden = NO;
        }
        if (obj[@"state"]) {
            model.state = obj[@"state"];
        }else {
            model.state = @(-1);
            _RequestStatusLabel.text = nil;
            _SdglLayoutConstraint.constant = CGFLOAT_MIN;
            _sdglView.hidden = YES; //  默认隐藏商家
            self.XfjlLayoutConstraint.constant = 49;
            self.xfjlView.hidden = NO; // 已审核隐藏申请列表
            return ;
        }
        switch (model.state.integerValue) {

            case 0:
            {
                self.reason = obj[@"reason"];
                model.stateString = @"已取消";
                self.ssdkBut.enabled = YES;
                _SdglLayoutConstraint.constant = CGFLOAT_MIN;
                _sdglView.hidden = YES; //  已取消隐藏商家
                self.XfjlLayoutConstraint.constant = 49;
                self.xfjlView.hidden = NO; // 已审核隐藏申请列表
                
            }
                break;
            case 2:
            {
                model.stateString = @"待審核";
                self.ssdkBut.enabled = NO;
                _SdglLayoutConstraint.constant = CGFLOAT_MIN;
                _sdglView.hidden = YES; //  待审核隐藏商家
                self.XfjlLayoutConstraint.constant = 49;
                self.xfjlView.hidden = NO; // 已审核隐藏申请列表
                
            }
                break;
            case 3:
            {
                model.stateString = @"已審核";
                self.XfjlLayoutConstraint.constant = CGFLOAT_MIN;
                self.xfjlView.hidden = YES; // 已审核隐藏申请列表
                _SdglLayoutConstraint.constant = 49;
                _sdglView.hidden = NO; //  显示商家
                
            }
                break;
            case 7:
            {
                model.stateString = @"已退件";
                self.reason = obj[@"reason"];
                self.ssdkBut.enabled = YES;
                _SdglLayoutConstraint.constant = CGFLOAT_MIN;
                _sdglView.hidden = YES; //  已退件隐藏商家
                self.XfjlLayoutConstraint.constant = 49;
                self.xfjlView.hidden = NO; // 已审核隐藏申请列表
            }
                break;
                
            default:
                break;
        }
        
        [self SupplierData:model];
    } failure:^(NSError * error) {
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
        //        _viewLayoutConstraint.constant = 50.0;
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
        ZPLog(@"%@",error);
    }];
}

- (void)SupplierData:(ZP_MyHopageModel2 *)model {
    
    _RequestStatusLabel.text = [NSString stringWithFormat:@"%@",model.stateString];
}

// UI
- (void)initUI {
    self.userBackView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.userBackView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.userBackView.layer.shadowOpacity = YES;
    self.sdglView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.sdglView.layer.shadowOffset = CGSizeMake(0, 0);
    self.sdglView.layer.shadowOpacity = 0.3;
    self.xfjlView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.xfjlView.layer.shadowOffset = CGSizeMake(0, 0);
    self.xfjlView.layer.shadowOpacity = 0.3;
     
//    self.zxxxView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    self.zxxxView.layer.shadowOffset = CGSizeMake(0, 0);
//    self.zxxxView.layer.shadowOpacity = 0.3;
    self.scanView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.scanView.layer.shadowOffset = CGSizeMake(0, 0);
    self.scanView.layer.shadowOpacity = 0.3;
}

- (void)updateUserInfo {
    if (Token) {
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        self.NameLabel.text = dic[@"nickname"];
    }
}

- (IBAction)LonigAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    UIViewController * viewController;
    if (DD_HASLOGIN) {
        viewController = [[SettingViewController alloc] init];
    } else {
        viewController = [[LogregisterController alloc] init];
    }
//    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}
// 设置
- (IBAction)settingAction:(id)sender {
    SettingViewController * settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];

    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

// 收藏
- (IBAction)scAction:(id)sender {
    CollectionViewController *collectionViewController = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionViewController animated:YES];

    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}
// 关注店铺（暂时不开启）- (IBAction)gzdpAction:(id)sender {
//    ConcernShopViewController *concernShopViewController = [[ConcernShopViewController alloc] init];
//    [self.navigationController pushViewController:concernShopViewController animated:YES];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
//    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;}
// 足迹
- (IBAction)zjAction:(id)sender {
    FootprintViewController *footprintViewController = [[FootprintViewController alloc] init];
    [self.navigationController pushViewController:footprintViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

//  商店管理
- (IBAction)sdglAction:(id)sender {
    StoreViewController *storeViewController = [[StoreViewController alloc] init];
    [self.navigationController pushViewController:storeViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

// 申请开店
- (IBAction)sskdAction:(id)sender {

        Supplier1ViewController * Supplier = [[Supplier1ViewController alloc]init];
        Supplier.stausType = self.RequestStatusStr.integerValue;
        Supplier.reason = self.reason;
    ZPLog(@"%ld -- %ld",Supplier.stausType,self.RequestStatusStr.integerValue);
    
        [self.navigationController pushViewController:Supplier animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    }
 
//}


//// 最新消息
//- (IBAction)zxxxAction:(id)sender {
//    NewsViewController *newsViewController = [[NewsViewController alloc] init];
//    [self.navigationController pushViewController:newsViewController animated:YES];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
//    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
//}
//  扫一扫
- (IBAction)scanAction:(id)sender {
    QCodeController * CodeController = [[QCodeController alloc]init];
    [self.navigationController pushViewController:CodeController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

// 彩票
- (IBAction)CaipiaoAction:(id)sender {
#pragma make -- 提示框
//    [SVProgressHUD showInfoWithStatus:@"暂时未到开放日期"];
    LotteryController * Lottery = [[LotteryController alloc]init];
    [self.navigationController pushViewController:Lottery animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]; // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

@end
