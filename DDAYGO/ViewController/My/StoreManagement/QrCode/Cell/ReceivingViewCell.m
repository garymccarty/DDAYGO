//
//  ReceivingViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/10/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ReceivingViewCell.h"
#import "PrefixHeader.pch"
#import <CoreImage/CoreImage.h>
#import "CIImage+Extension.h"
@implementation ReceivingViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    
}

- (void)initUI{
    
    ////  1.创建滤镜对象
    //    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //
    ////  2.恢复默认设置
    //    [filter setDefaults];
    //
    ////  3.设置数据
    ////    NSString *info = @"http://www.ddaygo.com/api/Test/getqrcode?token=&nonce=123";
    ////    NSString * info = @"H7XVKDMECZQ=";
    ////    NSString * info = @"http://www.ddaygo.com/api/Test/getqrcodepaylink?token=ec77b922d25bb303f27f63d23de84f73&amount=100&shopcode=H7XVKDMECZQ=&countrycode=886&payway=allpay_balance&icuetoken=nil";
    //
    //    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    //    [filter setValue:infoData forKeyPath:@"inputMessage"];
    //
    //    // 4.生成二维码
    //    CIImage * outputImage = [filter outputImage];
    //
    //    self.imageview.image = [outputImage createNonInterpolatedWithSize:150];
}

- (void)getInitWithUrl:(NSString *)url{
    //  1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //  2.恢复默认设置
    [filter setDefaults];
    
    //  3.设置数据
    NSString * info = url;
    
    NSData * infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    // 4.生成二维码
    CIImage * outputImage = [filter outputImage];
    
    //    self.imageview.image = [outputImage createNonInterpolatedWithSize:150];
    //    self.imageView.image = [UIImage imageWithCIImage:outputImage];
    self.imageview.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:ZP_Width-120];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end

