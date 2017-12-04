//
//  AppraiseController.h
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_OrderModel.h"
@interface AppraiseController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    NSArray * dataArray;
}

@property (nonatomic, strong) OrderModel *model;

@end
