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
}

- (IBAction)Determine:(id)sender {
    
    if (_PayTextField.text.length>0) {
        self.PayBlock(_PayTextField.text);
        
    }else{
        NSLog(@"money not empty！");
    }
}

- (void)initWithName:(NSString *)name NameId:(NSString *)nameId {
    _BusinessNameLabel.text = name;
    
    NSLog(@"id = %@",nameId);
}

// 键盘弹起
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.PayTextField resignFirstResponder];
}

@end
