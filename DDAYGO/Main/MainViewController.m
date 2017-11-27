//
//  MainViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ClassificationViewController.h"
#import "ShoppingViewController.h"
#import "OrderViewController.h"
#import "MyViewController.h"
#import "ThemeManager.h"
#import "UITabBarItem+Theme.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBarUI];
}

- (void) initTabBarUI {
    [[NSUserDefaults standardUserDefaults] setObject:@"6d864a3ef88554499df1878adcd65429" forKey:@"token"];
//  字体颜色
    NSDictionary * dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//  主页
    HomeViewController * homeViewController = [[HomeViewController alloc] init];
    UINavigationController * homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    homeNavigationController.tabBarItem = [UITabBarItem ImageName:@"ic_tab_home_normal.png" selectedImage:@"ic_tab_home_pressed.png"];
    [homeNavigationController.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    homeNavigationController.tabBarItem.title = NSLocalizedString(@"Home", nil);
    
//  类
    ClassificationViewController * classViewController = [[ClassificationViewController alloc] init];
    UINavigationController * classNavigationController = [[UINavigationController alloc] initWithRootViewController:classViewController];
    classNavigationController.tabBarItem = [UITabBarItem ImageName:@"ic_tab_sort_normal.png" selectedImage:@"ic_tab_sort_pressed.png"];
    [classNavigationController.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    classNavigationController.tabBarItem.title = NSLocalizedString(@"Class", nil);
    
//  购物车
    ShoppingViewController * shoppingViewController = [[ShoppingViewController alloc] init];
    UINavigationController * shoppingNavigationController = [[UINavigationController alloc] initWithRootViewController:shoppingViewController];
    shoppingNavigationController.tabBarItem = [UITabBarItem ImageName:@"ic_tab_shopping_normal.png" selectedImage:@"ic_tab_shopping_pressed.png"];
    [shoppingNavigationController.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    shoppingNavigationController.tabBarItem.title = NSLocalizedString(@"Shopping", nil);
    
//  订单
    OrderViewController * orderViewController = [[OrderViewController alloc] init];
    UINavigationController * orderNavigationController = [[UINavigationController alloc] initWithRootViewController:orderViewController];
    orderNavigationController.tabBarItem = [UITabBarItem ImageName:@"ic_tab_order_normal.png" selectedImage:@"ic_tab_order_pressed.png"];
    [orderNavigationController.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    orderNavigationController.tabBarItem.title = NSLocalizedString(@"Order", nil);

//  个人中心
    MyViewController * myViewController = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil];
    UINavigationController * myNavigationController = [[UINavigationController alloc] initWithRootViewController:myViewController];
    myNavigationController.tabBarItem = [UITabBarItem ImageName:@"ic_tab_Persona_normal.png" selectedImage:@"ic_tab_Persona_pressed.png"];
    [myNavigationController.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    myNavigationController.tabBarItem.title = NSLocalizedString(@"My", nil);
    [myViewController autoLogin:nil];
    NSArray * viewControllers = @[ homeNavigationController, classNavigationController, shoppingNavigationController, orderNavigationController, myNavigationController];
    
    self.viewControllers = viewControllers;
}



@end
