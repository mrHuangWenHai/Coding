//
//  HWMenuButton.m
//  Coding
//
//  Created by 黄文海 on 2018/3/20.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWMenuButton.h"

@implementation HWMenuButton

- (instancetype)initWithTitleName:(NSString*)name andIconName:(NSString*)iconName {
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = name;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_imageView];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect frame = self.frame;
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    _imageView.frame = CGRectMake(width*0.2, 0,width * 0.6, height * 0.6);
    _titleLabel.frame = CGRectMake(0, height*0.7, width, height*0.3);
}

@end
