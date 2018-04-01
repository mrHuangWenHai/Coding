//
//  HWSegmentHander.m
//  Coding
//
//  Created by 黄文海 on 2018/3/21.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWSegmentHander.h"
#import "CodingNetAPIManager.h"
#import "HWProjectModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+Expanded.h"

@interface HWSegmentHander()
@property(nonatomic, strong)UIScrollView* scrollView;
@property(nonatomic, strong)UIView* indicateView;
@property(nonatomic, strong)HWProjectModel* projectModel;
@end

@implementation HWSegmentHander

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetHeight(self.frame);
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height - 2)];
        _indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, height-2, 20, 2)];
        _indicateView.backgroundColor = [UIColor blueColor];
        [self addSubview:_scrollView];
        [self addSubview:_indicateView];
        [self refreshScrollView];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    self.scrollView.frame = CGRectMake(0, 0, width, height - 2);
    self.indicateView.frame = CGRectMake(0, height-2, 20, 2);
}

- (void)refreshScrollView {
    
    CGFloat width = CGRectGetWidth(self.scrollView.bounds);
    CGFloat height = CGRectGetHeight(self.scrollView.bounds);
    CGFloat leftSpare = 8;
    CGFloat topSpare = 10;
    CGFloat bottomSpare = 10;
    CGFloat imageHeight = height - topSpare - bottomSpare;
    CGFloat imageWidth = imageHeight;
    CGFloat lastX = 0;
    CGFloat totalWidth = (leftSpare + imageWidth) * self.projectModel.list.count;
    
    if (width < totalWidth) {
        self.scrollView.contentSize = CGSizeMake(totalWidth, height);
    }
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTask:)];
    UIImageView* allTaskImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tasks_all"]];
    allTaskImageView.userInteractionEnabled = YES;
    allTaskImageView.tag = 0;
    allTaskImageView.frame = CGRectMake(leftSpare, topSpare, imageWidth, imageHeight);
    [allTaskImageView addGestureRecognizer:tap];
    [self.scrollView addSubview:allTaskImageView];
    
    self.indicateView.center = CGPointMake(allTaskImageView.center.x, self.indicateView.center.y);
    lastX = leftSpare * 2 + imageWidth;
    __weak typeof(self) weakself = self;
    [self.projectModel.list enumerateObjectsUsingBlock:^(Project* project, NSUInteger idx, BOOL * _Nonnull stop) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTask:)];
        UIImageView* taskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(lastX, topSpare, imageWidth, imageHeight)];
        [taskImageView sd_setImageWithURL:[NSURL URLWithString:project.icon]];
        taskImageView.tag = idx + 1;
        taskImageView.userInteractionEnabled = YES;
        [taskImageView setCornerRadius];
        [taskImageView addGestureRecognizer:tap];
        [weakself.scrollView addSubview:taskImageView];
    }];
    
}

- (void)selectTask:(UITapGestureRecognizer *)gesture {
    
    UIImageView* imageView = (UIImageView*)gesture.view;
    [UIView animateWithDuration:0.2 animations:^{
        
        self.indicateView.center = CGPointMake(imageView.center.x, self.indicateView.center.y);
    }];
}

- (void)reloadSegmentData {
    __weak typeof(self) weakself = self;
    [[CodingNetAPIManager sharedManager] requestProjectsHaveTasksWithCompleteBlock:^(HWProjectModel *projectModel, NSError *error) {
        if (projectModel != nil) {
            weakself.projectModel = projectModel;
            [weakself refreshScrollView];
            weakself.projectHander(projectModel);
        } else {
            
        }
    }];
}




@end
