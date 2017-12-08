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
#import "ZP_MyTool.h"
#import "ZP_HomePageModel.h"
#import "ZP_LoginTool.h"

@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UIView * userBackView;
@property (weak, nonatomic) IBOutlet UIView * sdglView;
//@property (weak, nonatomic) IBOutlet UIView * xfjlView; 暂不需要
@property (weak, nonatomic) IBOutlet UIView * zxxxView;
@property (weak, nonatomic) IBOutlet UIView * scanView;
@property (weak, nonatomic) IBOutlet UIView * CaipiaoView;
@property (weak, nonatomic) IBOutlet UIButton *headImageBut;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self autoLogin:^(id obj) {
        if (!DD_HASLOGIN) {
            LogregisterController *viewcontroller = [[LogregisterController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewcontroller animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else {
            [self updateUserInfo];
        }
    }];
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

//- (void)viewWillAppear:(BOOL)animated {
//    self.hidesBottomBarWhenPushed = YES;
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//    self.hidesBottomBarWhenPushed = NO;
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor orangeColor]];
//}

- (void)autoLogin:(void (^)(id obj))success {
    if (DD_HASLOGIN) {
        if (success) {
            success(nil);
        }
    } else {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]) {
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"];
            [ZP_LoginTool requestLogin:dic success:^(id obj) {
                NSLog(@"obj---%@",obj);
                NSDictionary * dic = obj;
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"token"] forKey:@"token"];
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            [ZP_LoginTool getAccountInfo:dic[@"token"] success:^(id obj) {
                NSDictionary * tempDic = obj;
                NSDictionary *asdic = @{@"address":tempDic[@"address"],@"aid":tempDic[@"aid"],@"avatarimg":tempDic[@"avatarimg"],@"countrycode":tempDic[@"countrycode"],@"email":tempDic[@"email"],@"nickname":tempDic[@"nickname"],@"phone":tempDic[@"phone"],@"realname":tempDic[@"realname"],@"sex":tempDic[@"sex"],@"state":tempDic[@"state"]};
                [[NSUserDefaults standardUserDefaults] setObject:asdic forKey:@"userInfo"];
                DD_HASLOGIN = YES;
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

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
//    本地数据调用
    UIImage * image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
    if (image) {
        _headImageBut.layer.cornerRadius = 42;
        _headImageBut.layer.masksToBounds = YES;
        [_headImageBut setImage:image forState:UIControlStateNormal];
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
    
    [self allData];
}
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    dic[@"nonce"] = @"adf";
    [ZP_MyTool requestSetHomePage:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        ZP_HomePageModel * model = [[ZP_HomePageModel alloc]init];
        model.icueaccount = obj[@"icueaccount"];
        model.avatarimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@",obj[@"avatarimg"]];
        [self MyViewData:model];
    } failure:^(NSError * error) {
        
    }];
}
- (void)MyViewData:(ZP_HomePageModel *) model {
    _NameLabel.text = model.icueaccount;
}
- (void)initUI {
    self.userBackView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.userBackView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.userBackView.layer.shadowOpacity = YES;
    self.sdglView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.sdglView.layer.shadowOffset = CGSizeMake(0, 0);
    self.sdglView.layer.shadowOpacity = 0.3;
    /** 暂不需要
    self.xfjlView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.xfjlView.layer.shadowOffset = CGSizeMake(0, 0);
    self.xfjlView.layer.shadowOpacity = 0.3;
     */
    self.zxxxView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.zxxxView.layer.shadowOffset = CGSizeMake(0, 0);
    self.zxxxView.layer.shadowOpacity = 0.3;
    self.scanView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.scanView.layer.shadowOffset = CGSizeMake(0, 0);
    self.scanView.layer.shadowOpacity = 0.3;
}

- (void)updateUserInfo {
    if (DD_HASLOGIN) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        self.NameLabel.text = dic[@"nickname"];
    }
}

- (IBAction)LonigAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    UIViewController *viewController;
    if (DD_HASLOGIN) {
        viewController = [[SettingViewController alloc] init];
    } else {
        viewController = [[LogregisterController alloc] init];
    }
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)settingAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)scAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    CollectionViewController *collectionViewController = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)gzdpAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    ConcernShopViewController *concernShopViewController = [[ConcernShopViewController alloc] init];
    [self.navigationController pushViewController:concernShopViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)zjAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    FootprintViewController *footprintViewController = [[FootprintViewController alloc] init];
    [self.navigationController pushViewController:footprintViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    self.hidesBottomBarWhenPushed = NO;
}
//  商店管理
- (IBAction)sdglAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    StoreViewController *storeViewController = [[StoreViewController alloc] init];
    [self.navigationController pushViewController:storeViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    self.hidesBottomBarWhenPushed = NO;
}
/**暂不需要***
// 申请开店
- (IBAction)sskdAction:(id)sender {
    
}
*/

// 最新消息
- (IBAction)zxxxAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    NewsViewController *newsViewController = [[NewsViewController alloc] init];
    [self.navigationController pushViewController:newsViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    self.hidesBottomBarWhenPushed = NO;
}
//  扫一扫
- (IBAction)scanAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    QCodeController * CodeController = [[QCodeController alloc]init];
    [self.navigationController pushViewController:CodeController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    self.hidesBottomBarWhenPushed = NO;

    NSLog(@"跳转");
}
// 彩票
- (IBAction)CaipiaoAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    LotteryController * Lottery = [[LotteryController alloc]init];
    [self.navigationController pushViewController:Lottery animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]; // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    self.hidesBottomBarWhenPushed = NO;
}

@end
