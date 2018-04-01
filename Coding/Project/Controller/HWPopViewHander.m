//
//  HWPopViewHander.m
//  Coding
//
//  Created by 黄文海 on 2018/3/20.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWPopViewHander.h"
#import "HWCodingProjectViewController.h"
#import <UIKit/UIKit.h>
#import "HWMenuButton.h"
@interface HWPopViewHander()
@property(nonatomic, strong)UIView* view;
@property(nonatomic, strong)NSMutableArray* buttonArray;
@property(nonatomic, assign)BOOL isShow;
@end

@implementation HWPopViewHander
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    _isShow = NO;
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64)];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = _view.bounds;
    [_view addSubview:blurEffectView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideButtonMenu)];
    [_view addGestureRecognizer:tap];
    
}

- (NSMutableArray*)buttonArray {
    
    if (_buttonArray == NULL) {
        _buttonArray = [NSMutableArray arrayWithCapacity:6];
        NSArray* titleArray = @[@"项目",@"任务",@"冒泡",@"添加好友",@"私信",@"两步验证"];
        NSArray* imageUrlArray = @[@"pop_Project",@"pop_Task",@"pop_Tweet",@"pop_User",@"pop_Message",@"pop_2FA"];
        for (int i = 0; i < titleArray.count; i++) {
            HWMenuButton* button = [[HWMenuButton alloc] initWithTitleName:titleArray[i] andIconName:imageUrlArray[i]];
            button.frame = CGRectMake(0, 0, 100, 100);
            [_buttonArray addObject:button];
        }
        
    }
    return _buttonArray;
}

- (void)buttonMenuAnnimationWithStatus:(BOOL)status {
    
    __weak typeof(self) weakself = self;
    CGFloat left = 20;
    CGFloat spare = 17;
    CGFloat heightSpare = 20;
    CGFloat height = [UIScreen mainScreen].bounds.size.height / 2;
    [self.buttonArray enumerateObjectsUsingBlock:^(HWMenuButton* button, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGPoint originPoint;
        CGPoint destPoint;
        CASpringAnimation* moveAnimation = [[CASpringAnimation alloc] init];
        moveAnimation.keyPath = @"position";
        moveAnimation.damping = 10;
        if (idx / 3 == 0) {
            originPoint = CGPointMake(left+spare*(idx)+100*idx + 50, -((3-idx)*100 + (idx+1)*heightSpare + 50+ 50*(2-idx)));
            destPoint = CGPointMake(left+spare*(idx)+100*idx + 50, height - 60 - 64);
        } else {
            originPoint = CGPointMake(left+spare*(idx%3)+100*(idx%3) + 50, -((2-idx%3)*100 + (idx+1)*heightSpare + 50 + 50*(2-idx%3)));
            destPoint = CGPointMake(left+spare*(idx%3)+100*(idx%3) + 50, height+60-64);
        }
        if (status) {
            button.center = destPoint;
            moveAnimation.fromValue = [NSValue valueWithCGPoint:originPoint];
            moveAnimation.toValue = [NSValue valueWithCGPoint:destPoint];
            [weakself.view addSubview:button];
        } else {
            button.center = originPoint;
            moveAnimation.fromValue = [NSValue valueWithCGPoint:destPoint];
            moveAnimation.toValue = [NSValue valueWithCGPoint:originPoint];
        }

        moveAnimation.duration = moveAnimation.settlingDuration;
        [button.layer addAnimation:moveAnimation forKey:nil];
    }];
    
    if (!status) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.buttonArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [weakself.view removeFromSuperview];
        });
    }
    
}

- (void)hideButtonMenu {
    
    if (!self.isShow) {
        return;
    }
    [self buttonMenuAnnimationWithStatus:false];
    self.isShow = false;
    
}

- (void)showButtonMenu {
    
    if (self.isShow) {
        [self hideButtonMenu];
    } else {
        [self.projectController.view addSubview:self.view];
        [self buttonMenuAnnimationWithStatus:true];
        self.isShow = true;
    }
    
}


@end
