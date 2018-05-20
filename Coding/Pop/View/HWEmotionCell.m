//
//  HWEmotionCell.m
//  Coding
//
//  Created by 黄文海 on 2018/5/18.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWEmotionCell.h"
#import "PopHeader.h"
#import "HWEmotionImageCell.h"

@interface HWEmotionCell()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong)UICollectionView* emotionCollection;
@property(nonatomic, strong)UIPageControl* pageControl;
@end

@implementation HWEmotionCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat height = CGRectGetHeight(self.frame);
        layout.itemSize = CGSizeMake(kScreen_Width, height - 30);
        layout.minimumInteritemSpacing = 0;
        _emotionCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height - 80) collectionViewLayout:layout];
        _emotionCollection.pagingEnabled = true;
        _emotionCollection.backgroundColor = [UIColor whiteColor];
        _emotionCollection.delegate = self;
        _emotionCollection.dataSource = self;
        [_emotionCollection registerClass:[HWEmotionImageCell class] forCellWithReuseIdentifier:@"emotion"];

        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        [self.contentView addSubview:_emotionCollection];
        [self.contentView addSubview:_pageControl];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat pageControlHeight = 30;
    CGFloat pageControlWidth = 80;
    CGFloat height = CGRectGetHeight(self.frame);
    self.emotionCollection.frame = CGRectMake(0, 0, kScreen_Width, height - pageControlHeight);
    self.pageControl.frame = CGRectMake((kScreen_Width - pageControlWidth)/2, height - pageControlHeight, pageControlWidth, pageControlHeight);
}

- (void)setEmotionArray:(NSArray *)emotionArray {
    _emotionArray = emotionArray;
    [self.emotionCollection reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.pageControl.numberOfPages = self.emotionArray.count / 20;
    return self.emotionArray.count / 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"------------------------ %ld",(long)indexPath.row);
    HWEmotionImageCell* emotionImageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"emotion" forIndexPath:indexPath];
    emotionImageCell.backgroundColor = [UIColor yellowColor];
    emotionImageCell.emotionArray = [self.emotionArray subarrayWithRange:NSMakeRange(indexPath.row * 20, 20)];
    NSLog(@"======================== %ld",emotionImageCell.emotionArray.count);
    return emotionImageCell;
}

@end
