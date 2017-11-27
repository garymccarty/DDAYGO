//
//  BindingIntroduce.m
//  DDAYGO
//
//  Created by Summer on 2017/11/27.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BindingIntroduce.h"
#import "PromptBox.h"
@interface BindingIntroduce ()

@end

@implementation BindingIntroduce

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"绑定推荐人", nil);
    
}
// 绑定推荐人
- (IBAction)BindingIntroduceTextField:(id)sender {
    [[PromptBox getInstance] showDialogBoxWithOperation:DDABuildingICUC FinishBlock:nil];
}


@end
