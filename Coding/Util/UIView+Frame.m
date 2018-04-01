//
//  UIView+Frame.m
//  Coding
//
//  Created by 黄文海 on 2018/3/26.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)getX {
    
    return CGRectGetWidth(self.frame) + self.frame.origin.x;
}

- (CGFloat)getY {
    
    return CGRectGetHeight(self.frame) + self.frame.origin.y;
    
}
@end
