//
//  HWGitButton.h
//  Coding
//
//  Created by 黄文海 on 2018/5/25.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GitButtonType) {
    Fork = 0,
    Watch,
    Star
};

@interface HWGitButton : UIView
@property(nonatomic, assign)BOOL check;
- (instancetype)initWithButtonType:(GitButtonType)buttonType;
- (void)setContentOfButton:(NSString*)title;
@end
