//
//  HWSwipeBetweenViewControllers.m
//  Coding
//
//  Created by 黄文海 on 2018/4/7.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWSwipeBetweenViewControllers.h"
#import "HWEasePageViewController.h"
#import "PopHeader.h"

@interface HWSwipeBetweenViewControllers ()<UIPageViewControllerDataSource>
@property(nonatomic, assign)NSUInteger index;
@end

@implementation HWSwipeBetweenViewControllers

+ (instancetype)newHWSwipeBetweenViewControllers {
    HWEasePageViewController* easePageViewController = [[HWEasePageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    return [[HWSwipeBetweenViewControllers alloc] initWithRootViewController:easePageViewController];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        if ([rootViewController isKindOfClass:[UIPageViewController class]]) {
            _pageViewController = (UIPageViewController*)rootViewController;
            _pageViewController.dataSource = self;
        }
        _index = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.pageViewController setViewControllers:@[[self.viewControllerArray objectAtIndex:(self.index)]] direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
}

- (void)setupSegmentButtons {
    
    CGFloat pageControlHeight = 20;
    CGFloat height = CGRectGetHeight(self.navigationBar.frame) - pageControlHeight;
    UIView* contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, height + pageControlHeight)];
    UIScrollView* buttonContainer =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, height)];
    buttonContainer.showsHorizontalScrollIndicator = NO;
    buttonContainer.contentSize = CGSizeMake(BUTTON_WIDTH * _buttonTitleArray.count, 0);
    for (int i = 0; i < _buttonTitleArray.count; i++) {
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(i * BUTTON_WIDTH, 0, BUTTON_WIDTH, height)];
        [button setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kNavTitleFontSize];
        [button setTitleColor:kColorNavTitle forState:UIControlStateNormal];
        [buttonContainer addSubview:button];
    }
    [contentView addSubview:buttonContainer];
    
    UIPageControl* pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height, BUTTON_WIDTH, pageControlHeight)];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:118/255.0 green:128/255.0 blue:142/255.0 alpha:1];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    [contentView addSubview:pageControl];
    self.pageViewController.navigationItem.titleView = contentView;
}

- (void)setButtonTitleArray:(NSArray *)buttonTitleArray {
    _buttonTitleArray = buttonTitleArray;
    [self setupSegmentButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController {
    return nil;
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    return nil;
}
@end
