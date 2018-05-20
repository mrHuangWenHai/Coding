//
//  UIImageView+Expanded.m
//  Coding
//
//  Created by 黄文海 on 2018/3/26.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "UIImageView+Expanded.h"

@implementation UIImageView (Expanded)

- (void)setCornerRadius {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
