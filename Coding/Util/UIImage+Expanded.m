//
//  UIImage+Expanded.m
//  Coding
//
//  Created by 黄文海 on 2018/3/16.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "UIImage+Expanded.h"
#import "YLGIFImage.h"

@implementation UIImage (Expanded)

+ (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size {
    
    CGRect rect =CGRectMake(0,0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (UIImage*)gifImageWithName:(NSString*)name {
    
    UIImage* image = [YLGIFImage imageNamed:name];
    
    return image;
}

@end
