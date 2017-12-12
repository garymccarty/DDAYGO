//
//  MyViewController.h
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, DDPopKind)
{
    DDFromChildVC           = 0,
    DDFromDataVC            = 1
};

@interface MyViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel * NameLabel; // 名字
@property (strong, nonatomic) IBOutlet UILabel * CollectionLabel; // 收藏
@property (weak, nonatomic) IBOutlet UILabel *TrackingStoreLabel; // 关注店铺
@property (strong, nonatomic) IBOutlet UILabel * BrowseLabel; // 足迹

@property (nonatomic ,assign) BOOL hasLogin;
@property (nonatomic ,assign) DDPopKind popKind;

+ (MyViewController *)sharedInstanceTool;

- (void)autoLogin:(void (^)(id obj))success;
@end
