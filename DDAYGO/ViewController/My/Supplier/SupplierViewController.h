//
//  SupplierViewController.h
//  DDAYGO
//
//  Created by Summer on 2017/12/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * CountriesLabel;  // 国家
@property (nonatomic, strong) UILabel * TissueMorphologyLabel; // 组织形态

@end
