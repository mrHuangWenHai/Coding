//
//  HWMenuButton.h
//  Coding
//
//  Created by 黄文海 on 2018/3/20.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWMenuButton : UIView
@property(nonatomic, strong)UILabel* titleLabel;
@property(nonatomic, strong)UIImageView* imageView;

- (instancetype)initWithTitleName:(NSString*)name andIconName:(NSString*)iconName;
@end
