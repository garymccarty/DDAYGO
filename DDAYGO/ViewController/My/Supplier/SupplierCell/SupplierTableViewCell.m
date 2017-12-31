//
//  SupplierTableViewCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SupplierTableViewCell.h"
#import "PrefixHeader.pch"
@implementation SupplierTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.savaData) {
        self.savaData(textField.text);
    }
    
    return YES;
}
@end
