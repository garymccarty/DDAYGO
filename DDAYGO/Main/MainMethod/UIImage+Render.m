//
//  UIImage+Render.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)
+ (UIImage *)imageNamedWithOriginalImage:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end

