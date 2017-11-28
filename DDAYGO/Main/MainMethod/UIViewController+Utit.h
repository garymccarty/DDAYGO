//
//  UIViewController+Utit.h
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Util)
- (void)setBackButton;
- (void)setCancelButton;
- (void)setGoBackOrDismissButtonAuto;
-(void)dismissAutomatically;
//- (void) showLoading;
//-(void)showLoadingOnLandscape;
//- (void) hideLoading;
//- (void) showText:(NSString*)str;
//- (void) showError:(NSError*)error;
- (void) setRightBarButtonWithTitle:(NSString*)aTitle target:(id)aTarget action:(SEL)aAction;
- (void) setRightBarButtonWithImage:(UIImage*)image target:(id)aTarget action:(SEL)aAction;
- (void) setLeftBarButtonWithImage:(UIImage*)image target:(id)aTarget action:(SEL)aAction;


@end

