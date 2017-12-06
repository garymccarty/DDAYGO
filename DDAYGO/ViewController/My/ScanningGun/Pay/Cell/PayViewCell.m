//
//  PayViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/10/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "PayViewCell.h"

@implementation PayViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)Determine:(id)sender {
    if (_PayTextField.text.length>0) {
        self.PayBlock(_PayTextField.text);
    }else{
        NSLog(@"money not empty！");
    }
}

// 键盘弹起

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    textField.keyboardType = UIKeyboardTypeNumberPad
    [super touchesBegan:touches withEvent:event];
    [self.PayTextField resignFirstResponder];
}

@end
