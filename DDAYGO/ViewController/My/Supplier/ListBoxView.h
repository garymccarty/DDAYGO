//
//  ListBoxView.h
//  HibyMusic
//
//  Created by 赵宁 on 2017/5/17.
//  Copyright © 2017年 hibymusic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ListBoxBlock)(NSString *string);
@interface ListBoxView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong ,nonatomic) NSArray *array;
@property (assign ,nonatomic) CGFloat cellHeight;
@property (assign ,nonatomic) CGFloat tableViewSh;
@property (copy ,nonatomic) NSString *curString;
@property (strong ,nonatomic) ListBoxBlock listBoxBlock;

- (void)showTableViewWithDic:(NSDictionary *)dic SuperViewFrame:(CGRect)superFrame SenderBtnFrame:(CGRect)senderFrame ListBoxBlock:(ListBoxBlock)listBoxBlock;
@end
