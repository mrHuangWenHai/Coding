//
//  HWTextCell.m
//  Coding
//
//  Created by 黄文海 on 2018/3/30.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWTextCell.h"
#import "UIColor+Expanded.h"
#import "UIImageView+Expanded.h"

@implementation HWTextCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.statusLabel.textColor = [UIColor colorWithHexString:@"0x76808E"];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"0x323A45"];
    // Initialization code
}

- (void)layoutSubviews {
    if ([self.nameLabel.text isEqualToString:@"所属项目"]) {
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 34, 34) byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //设置大小
        maskLayer.frame = self.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        self.textImageView.layer.mask = maskLayer;
        
    } else {
        [self.textImageView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperlayer];
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
