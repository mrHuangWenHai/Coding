//
//  UIButton+Common.m
//  Coding
//
//  Created by 黄文海 on 2018/4/14.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "UIButton+Common.h"
#import "UIColor+Expanded.h"

@implementation UIButton (Common)
- (void)tweetBtnAlignmentLeft:(BOOL)alignmentLeft{
    
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitleColor:[UIColor colorWithHexString:@"0x76808E"] forState:UIControlStateNormal];
    if (alignmentLeft) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    }else{
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    }
}

@end
