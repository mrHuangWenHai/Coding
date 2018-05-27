//
//  HWEmotionKeyboardView.m
//  Coding
//
//  Created by 黄文海 on 2018/5/17.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWEmotionKeyboardView.h"
#import "PopHeader.h"
#import "UIView+Frame.h"
#import "HWEmotionModel.h"
#import "HWEmotionCell.h"

@interface HWEmotionKeyboardView()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong)UICollectionView* emotionCollection;
@property(nonatomic, strong)UIButton* sendButton;
@property(nonatomic, strong)UIScrollView* buttonScrollView;
@property(nonatomic, copy)NSArray* imageArray;
@property(nonatomic, strong)HWEmotionModel* emotionModel;
@end

//keyboard_emotion_delete
//keyboard_emotion_emoji keyboard_emotion_emoji_code

@implementation HWEmotionKeyboardView

- (instancetype)initWithFrame:(CGRect)frame andImageArray:(NSArray*)imageArray {
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = imageArray;
        _emotionModel = [[HWEmotionModel alloc] init];
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreen_Width, kKeyboardView_Height - kKeyboardView_ToolBar_Height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _emotionCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kKeyboardView_Height - kKeyboardView_ToolBar_Height) collectionViewLayout:layout];
    [_emotionCollection registerClass:[HWEmotionCell class] forCellWithReuseIdentifier:@"emotionCell"];
    _emotionCollection.scrollEnabled = NO;
    _emotionCollection.delegate = self;
    _emotionCollection.dataSource = self;
    [self addSubview:_emotionCollection];
    
    CGFloat buttonWidth = 40;
    _buttonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kKeyboardView_Height - kKeyboardView_ToolBar_Height, kScreen_Width - buttonWidth, kKeyboardView_ToolBar_Height)];
    _buttonScrollView.showsVerticalScrollIndicator = NO;
    _buttonScrollView.showsHorizontalScrollIndicator = NO;
    if (buttonWidth * self.imageArray.count > kScreen_Width - buttonWidth) {
        _buttonScrollView.contentSize = CGSizeMake(buttonWidth * self.imageArray.count, 0);
    }
    
    [self.imageArray enumerateObjectsUsingBlock:^(NSString* imageurl, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(idx * buttonWidth, 0, buttonWidth, kKeyboardView_ToolBar_Height)];
        [button setImage:[UIImage imageNamed:imageurl] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = idx;
        [_buttonScrollView addSubview:button];
    }];
    [self addSubview:_buttonScrollView];
    
    _sendButton = [[UIButton alloc] init];
    _sendButton.backgroundColor = [UIColor blueColor];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendEmotion:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendButton];
}

- (void)layoutSubviews {
    
    CGFloat buttonWidth = 40;
    self.emotionCollection.frame = CGRectMake(0, 0, kScreen_Width, kKeyboardView_Height - kKeyboardView_ToolBar_Height);
    self.buttonScrollView.frame = CGRectMake(0, kKeyboardView_Height - kKeyboardView_ToolBar_Height, kScreen_Width - buttonWidth, kKeyboardView_ToolBar_Height);
    self.sendButton.frame = CGRectMake(self.buttonScrollView.getX, self.emotionCollection.getY, buttonWidth, kKeyboardView_ToolBar_Height);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HWEmotionCell* emotionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"emotionCell" forIndexPath:indexPath];
    emotionCell.emotionArray = [self.emotionModel getEmotionArrayWithIndex:indexPath.row];
    return emotionCell;
}

- (void)selectButton:(UIButton*)clickButton {
    CGFloat offsetX = clickButton.tag * kScreen_Width;
    self.emotionCollection.contentOffset = CGPointMake(offsetX, 0);
    
}

- (void)sendEmotion:(UIButton*)sendButton {
    
}

@end
