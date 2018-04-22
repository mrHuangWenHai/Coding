//
//  HWImageView.m
//  Coding
//
//  Created by 黄文海 on 2018/4/14.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWImageView.h"

@implementation HWImageView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = true;
        UIGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)handleTap {
    self.tap();
}

@end
