//
//  HWBannderHandler.m
//  Coding
//
//  Created by 黄文海 on 2018/4/9.
//  Copyright © 2018年 huang. All rights reserved.
//

#define UISCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define UISCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define kColorDark7 [UIColor colorWithHexString:@"0x76808E"]


#import "HWBannderHandler.h"
#import "HWBannerModel.h"
#import "YYText.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+Expanded.h"


@interface HWBannderHandler() <UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView* bannerScrollView;
@property(nonatomic, strong)UIPageControl* pageControl;
@property(nonatomic, strong)YYLabel* messageLabel;
@property(nonatomic, strong)NSTimer* autoScrollTimer;
@property(nonatomic, copy)NSArray* imageArray;
@property(nonatomic, assign)NSInteger currentPage;
@property(nonatomic, strong)UIImageView* firstView;
@property(nonatomic, strong)UIImageView* middleView;
@property(nonatomic, strong)UIImageView* lastView;
@property(nonatomic, copy)NSArray* attrArray;
@end

@implementation HWBannderHandler

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews {
    
    UIImageView* imageView1 = [[UIImageView alloc] init];
    UIImageView* imageView2 = [[UIImageView alloc] init];
    UIImageView* imageView3 = [[UIImageView alloc] init];
    _imageArray = @[imageView1, imageView2, imageView3];
    
    _bannerScrollView = [[UIScrollView alloc] init];
    _bannerScrollView.contentSize = CGSizeMake(UISCREEN_WIDTH * 3, 0);
    _bannerScrollView.pagingEnabled = true;
    _bannerScrollView.showsVerticalScrollIndicator = NO;
    _bannerScrollView.delegate = self;
    _bannerScrollView.showsHorizontalScrollIndicator = NO;
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:118/255.0 green:128/255.0 blue:142/255.0 alpha:1];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    _messageLabel = [[YYLabel alloc] init];
    [self addSubview:_bannerScrollView];
    [self addSubview:_pageControl];
    [self addSubview:_messageLabel];
}

- (void)setUp {
    
    _currentPage = 0;
    _pageControl.currentPage = _currentPage;
    __weak typeof(self) weakSelf = self;
    _autoScrollTimer = [NSTimer timerWithTimeInterval:3 repeats:true block:^(NSTimer * _Nonnull timer) {
        [weakSelf autoScroll];
    }];
    [[NSRunLoop currentRunLoop] addTimer:_autoScrollTimer forMode:NSDefaultRunLoopMode];
}

- (void)layoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat messageHeight = 44;
    CGFloat pageControlWidth = 80;
    self.bannerScrollView.frame = CGRectMake(0, 0, width, width * 0.4);
    self.messageLabel.frame = CGRectMake(9 , self.bannerScrollView.getY + 8, width - pageControlWidth, messageHeight - 16);
    self.pageControl.frame = CGRectMake(self.messageLabel.getX + 5, self.bannerScrollView.getY + 8, pageControlWidth - 5, messageHeight - 16);
    
}

- (void)setBannerModels:(NSArray *)bannerModels {
    
    _bannerModels = bannerModels;
    [self setUp];
    NSMutableArray* attrArray = [[NSMutableArray alloc] init];
    for (HWBannerModel* model in _bannerModels) {
    
        NSString* content = [NSString stringWithFormat:@"%@ %@",model.name, model.title];
        NSMutableAttributedString* attr1 = [[NSMutableAttributedString alloc] initWithString:content];
        YYTextBorder* border = [[YYTextBorder alloc] init];
        border.strokeWidth = 2;
        border.strokeColor = [UIColor colorWithRed:247/255.0 green:248/255.0 blue:249/255.0 alpha:1];
        border.cornerRadius = 2;
        [attr1 yy_setTextBorder:border range:[attr1.string rangeOfString:model.name]];
        [attr1 yy_setColor:kColorDark7 range:[attr1.string rangeOfString:model.name]];
        [attr1 yy_setFont:[UIFont systemFontOfSize:10] range:[attr1.string rangeOfString:model.name]];
        [attr1 yy_setFont:[UIFont systemFontOfSize:12] range:[attr1.string rangeOfString:model.title]];
        [attrArray addObject:attr1];
    }
    self.attrArray = [attrArray copy];
    [self reloadData];
}

- (void)autoScroll {
    _currentPage = (_currentPage + 1) % self.imageArray.count;
    CGFloat width = CGRectGetWidth(self.frame);
    self.pageControl.currentPage = _currentPage;
    [self.bannerScrollView setContentOffset:CGPointMake(2 * width, 0) animated:true];
}

- (void)reloadData {
    
    [self.firstView removeFromSuperview];
    [self.middleView removeFromSuperview];
    [self.lastView removeFromSuperview];
    
    unsigned long count = self.imageArray.count - 1;
    CGFloat width = CGRectGetWidth(self.frame);
    NSUInteger first,middle,last;
    
    if (_currentPage == 0) {
        
        self.firstView = self.imageArray[count];
        self.middleView = self.imageArray[0];
        self.lastView = self.imageArray[1];
        first = count;
        middle = 0;
        last = 1;

    } else if (_currentPage == count) {
        
        self.firstView = self.imageArray[count - 1];
        self.middleView = self.imageArray[count];
        self.lastView = self.imageArray[0];
        first = count - 1;
        middle = count;
        last = 0;
        
    } else {
        self.firstView = self.imageArray[_currentPage - 1];
        self.middleView = self.imageArray[_currentPage];
        self.lastView = self.imageArray[_currentPage + 1];
        first = _currentPage - 1;
        middle = _currentPage;
        last = _currentPage + 1;
    }
    
    if (self.attrArray.count > _currentPage) {
        self.messageLabel.attributedText = self.attrArray[_currentPage];
    }
    
    [self.firstView sd_setImageWithURL:[NSURL URLWithString:self.bannerModels[first].image]];
    [self.middleView sd_setImageWithURL:[NSURL URLWithString:self.bannerModels[middle].image]];
    [self.lastView sd_setImageWithURL:[NSURL URLWithString:self.bannerModels[last].image]];
    self.firstView.frame = CGRectMake(0, 0, width, width*0.4);
    self.middleView.frame = CGRectMake(width, 0, width, width*0.4);
    self.lastView.frame = CGRectMake(width*2, 0, width, width*0.4);
    [self.bannerScrollView addSubview:self.firstView];
    [self.bannerScrollView addSubview:self.middleView];
    [self.bannerScrollView addSubview:self.lastView];
    self.bannerScrollView.contentOffset = CGPointMake(width, 0);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    __weak typeof(self) weakSelf = self;
    _autoScrollTimer = [NSTimer timerWithTimeInterval:3 repeats:true block:^(NSTimer * _Nonnull timer) {
        [weakSelf autoScroll];
    }];
    [[NSRunLoop currentRunLoop] addTimer:_autoScrollTimer forMode:NSDefaultRunLoopMode];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (index == 0) {
        self.currentPage--;
        if (self.currentPage == -1) self.currentPage = self.imageArray.count - 1;
    } else if (index == 2){
        self.currentPage = (self.currentPage + 1) % self.imageArray.count;
    }
    self.pageControl.currentPage = self.currentPage;
    [self reloadData];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self reloadData];
}


@end
