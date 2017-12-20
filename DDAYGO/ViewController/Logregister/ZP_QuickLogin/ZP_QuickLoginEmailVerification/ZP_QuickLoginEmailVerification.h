//
//  ZP_QuickLoginEmailVerification.h
//  DDAYGO
//
//  Created by Summer on 2017/12/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextView.h"
@interface ZP_QuickLoginEmailVerification : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView * EmailVerificationscrollView;
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextFiled;
@property (weak, nonatomic) IBOutlet TextView * ZPCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton * RegBut;

@end
