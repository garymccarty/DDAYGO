//
//  PayPassController.m
//  DDAYGO
//
//  Created by Login on 2017/10/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "PayPassController.h"
#import "OrderViewController.h"
@interface PayPassController ()

@end

@implementation PayPassController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
//    for (UIViewController * controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[OrderViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
    // Do any additional setup after loading the view from its nib.
}
//- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    [super viewWillAppear:animated];
//}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
    
}


@end
