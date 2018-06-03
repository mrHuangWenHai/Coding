//
//  HWGitView.m
//  Coding
//
//  Created by 黄文海 on 2018/5/31.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWGitView.h"
#import "HWGitButton.h"
#import "UIView+Frame.h"

@interface HWGitView()
@property(nonatomic, strong)NSArray* gitButtonArray;
@end

@implementation HWGitView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initGitButton];
    }
    return self;
}

- (void)initGitButton {
    HWGitButton* startButton = [[HWGitButton alloc] initWithButtonType:Star];
    HWGitButton* watchButton = [[HWGitButton alloc] initWithButtonType:Watch];
    HWGitButton* forkButton = [[HWGitButton alloc] initWithButtonType:Fork];
    [self addSubview:startButton];
    [self addSubview:watchButton];
    [self addSubview:forkButton];
    _gitButtonArray = @[startButton, watchButton, forkButton];
}

- (void)layoutSubviews {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat leftSpare = 8;
    CGFloat topSpare = 7;
    CGFloat spare = 5;
    CGFloat buttonWidth = (width - 2 * leftSpare - 2 * spare)/3;
    CGFloat buttonHeight = height - 2 * topSpare;
    
    HWGitButton* startButton = self.gitButtonArray[0];
    startButton.frame = CGRectMake(leftSpare, topSpare, buttonWidth, buttonHeight);
    
    HWGitButton* watchButton = self.gitButtonArray[1];
    watchButton.frame = CGRectMake(startButton.getX + spare, topSpare, buttonWidth, buttonHeight);
    
    HWGitButton* forkButton = self.gitButtonArray[2];
    forkButton.frame = CGRectMake(watchButton.getX + spare, topSpare, buttonWidth, buttonHeight);    
}

- (void)updateGitWith:(Project*)project {
    
    HWGitButton* startButton = self.gitButtonArray[0];
    [startButton setContentOfButton:[NSString stringWithFormat:@"%ld",project.stared]];
    
    HWGitButton* watchButton = self.gitButtonArray[1];
    [watchButton setContentOfButton:[NSString stringWithFormat:@"%ld",project.watched]];
    
    HWGitButton* forkButton = self.gitButtonArray[2];
    [forkButton setContentOfButton:[NSString stringWithFormat:@"%ld",project.forked]];
    
}

@end
