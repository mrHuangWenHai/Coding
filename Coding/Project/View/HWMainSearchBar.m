//
//  HWMainSearchBar.m
//  Coding
//
//  Created by 黄文海 on 2018/3/15.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWMainSearchBar.h"

@implementation HWMainSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CALayer* topLayer = [[CALayer alloc] init];
        topLayer.frame = CGRectMake(0, 0, frame.size.width, 1);
        topLayer.backgroundColor = [UIColor colorWithRed:242/255.0 green:244/255.0 blue:246/255.0 alpha:1].CGColor;
        [self.layer addSublayer:topLayer];
        
        CALayer* bottomLayer = [[CALayer alloc] init];
        bottomLayer.frame = CGRectMake(0, frame.size.height - 1, frame.size.width, 1);
        bottomLayer.backgroundColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:bottomLayer];
        
    }
    return self;
}

- (UIButton*)scanButton {
    
    if (_scanButton == NULL) {
        
        CGRect frame = self.frame;
        _scanButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 40, 0, 30, frame.size.height)];
        [_scanButton setImage:[UIImage imageNamed:@"button_scan"] forState:UIControlStateNormal];
        [self addSubview:_scanButton];
        
    }
    return _scanButton;
}


@end
