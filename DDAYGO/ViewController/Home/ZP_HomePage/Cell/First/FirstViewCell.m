//
//  FirstViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FirstViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_HomeTool.h"
#import "UIButton+UIButtonImageWithLable.h"
#import "ZP_FirstModel.h"
@implementation FirstViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"First"];
    if (self) {
        self.contentView.userInteractionEnabled = YES;
        [self Alldata];
    }
    return self;
}
- (void)first:(NSArray *)sup {
    NSMutableArray * arr = [NSMutableArray array];
    NSMutableArray * arrar = [NSMutableArray array];
    _Allarr = sup;
    NSMutableArray * arrid = [NSMutableArray array];
    for (ZP_FirstModel * model in sup) {
        [arr addObject:model.menuname];
        [arrar addObject:[NSString stringWithFormat:@"http://www.ddaygo.com%@",[model.imgurl stringByReplacingOccurrencesOfString:@"~" withString:@""]]];
        [arrid addObject:model.typeid];
    }

    NSInteger num = 0;
    for (int z = 0; z <= 1; z ++) {
        UIView * view = [UIView new];
        view.backgroundColor = ZP_Graybackground;
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            make.top.equalTo(self).offset(ZP_Width/2/2-0.5); // 高
            make.height.mas_equalTo(1); // 高
            make.width.mas_offset(ZP_Width-5);
        }];
        
        for (int i = 0; i <= 3; i ++) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i * ZP_Width / 4 , z * ZP_Width / 4 , ZP_Width / 4 , ZP_Width / 4 )];
            button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.font = ZP_titleFont;
            [button setTitleColor:ZP_textblack forState:UIControlStateNormal];
            if (z == 0) {
                [self ZP_setButton:button ImageWithUrl:arrar[i] WithName:arr[i]];
            }
            if (z == 1) {
                [self ZP_setButton:button ImageWithUrl:arrar[i+4] WithName:arr[i+4]];
            }
            button.tag = [arrid[num] integerValue];
            [button addTarget:self action:@selector(buttonType:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            num ++;
        }
    }
    
}

- (void)Alldata {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"countrycode"] = @"886";
    [ZP_HomeTool requesFirst:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSArray *ARR = [ZP_FirstModel mj_objectArrayWithKeyValuesArray:obj];
        [self first:ARR];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
//        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
    }];
}

- (void)buttonType:(UIButton *)sender {

    NSMutableArray * arrid = [NSMutableArray array];
    
    for (ZP_FirstModel * model in _Allarr) {
        [arrid addObject:model.typeid];
        if ([model.typeid integerValue] == sender.tag) {
             self.firstBlock(sender.tag,model.menuname);
        }
    }
    
}

- (void)ZP_setButton:(UIButton *)btn ImageWithUrl:(NSString *)urlStr WithName:(NSString *)name {
    [[SDImageCache sharedImageCache] storeImage:btn.imageView.image forKey:urlStr toDisk:NO];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:nil completed:^(UIImage * image, NSError * error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            CGSize imagesize;
            imagesize.height = 60;
            imagesize.width = 60;
//            UIImage *image1 = [self imageWithImage:image scaledToSize:imagesize];
            [btn setImage:image forState:UIControlStateNormal];
            [btn setTitle:name forState:UIControlStateNormal];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 5, 0);
            [btn resizeWithDistance:10];
        });
    }];
}


- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



@end
