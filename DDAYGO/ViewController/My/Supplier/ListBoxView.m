//
//  ListBoxView.m
//  HibyMusic
//
//  Created by 赵宁 on 2017/5/17.
//  Copyright © 2017年 hibymusic. All rights reserved.
//

#import "ListBoxView.h"

@implementation ListBoxView

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.BGView addGestureRecognizer:tap];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.cellHeight = 30;
}

- (void)showTableViewWithDic:(NSDictionary *)dic SuperViewFrame:(CGRect)superFrame SenderBtnFrame:(CGRect)senderFrame ListBoxBlock:(ListBoxBlock)listBoxBlock {
    self.listBoxBlock = listBoxBlock;
    
    self.array = dic[@"data"];

    CGFloat ox = superFrame.origin.x + senderFrame.origin.x + senderFrame.size.width;
    CGFloat oy = superFrame.origin.y + senderFrame.origin.y + self.array.count * self.cellHeight/2;
    
    CGFloat tableViewOx,tableViewOy;
    CGFloat tableViewMaxH = 150;
    self.tableViewSh = self.array.count * self.cellHeight;
    if (self.tableViewSh > tableViewMaxH) {
        self.tableViewSh = tableViewMaxH;
    }
    
    if (self.frame.size.width - ox >= [dic[@"width"] floatValue]*0.6) {
        tableViewOx = ox;
    } else {
        tableViewOx = self.frame.size.width - [dic[@"width"] floatValue]*0.6;
    }
    
    if ((oy - self.array.count * self.cellHeight / 2) >0 && (self.frame.size.height - oy - self.array.count * self.cellHeight / 2) > 0) {
        tableViewOy = oy - self.array.count * self.cellHeight/2;
    } else {
        tableViewOy = 0;
        self.tableViewSh = self.frame.size.height;
    }
    
    self.tableView.frame = CGRectMake(110 + _curString.length*15, senderFrame.origin.y + 40, [dic[@"width"] floatValue]*0.6, 0);
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    self.hidden = NO;
    [self.tableView reloadData];
    [UIView animateWithDuration:.3f animations:^{
//        self.tableView.alpha = 1;
        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableViewSh)];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.3f animations:^{
        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 0)];
    } completion:^(BOOL finished) {
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

#pragma mark --- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cellHeight;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    AudioItem *audioItem = [self.array objectAtIndex:indexPath.row];
//    [cell updateCellWithAudioItem:audioItem];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.text = self.array[indexPath.row];
    if ([cell.textLabel.text isEqualToString:self.curString]) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _curString = self.array[indexPath.row];
    [tableView reloadData];
    self.listBoxBlock(self.array[indexPath.row]);
    [self dismiss];
}

@end
