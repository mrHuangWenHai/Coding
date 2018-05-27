//
//  HWEmotionImageCell.m
//  Coding
//
//  Created by 黄文海 on 2018/5/18.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWEmotionImageCell.h"
#import "PopHeader.h"
#import "HWImageCell.h"

@interface HWEmotionImageCell()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong)UICollectionView* imageCollection;
@end

@implementation HWEmotionImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat spare = 9;
        CGFloat imageWidth = (kScreen_Width - 16 - 6 * spare) / 7;
        layout.itemSize = CGSizeMake(imageWidth, imageWidth);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        _imageCollection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _imageCollection.panGestureRecognizer.allowedTouchTypes = @[];
        _imageCollection.backgroundColor = [UIColor whiteColor];
        [_imageCollection registerNib:[UINib nibWithNibName:@"HWImageCell" bundle:nil] forCellWithReuseIdentifier:@"image"];
        _imageCollection.delegate = self;
        _imageCollection.dataSource = self;
        [self.contentView addSubview:_imageCollection];
    }
    return self;
}

- (void)setEmotionArray:(NSArray *)emotionArray {
    _emotionArray = emotionArray;
    [self.imageCollection reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.emotionArray) {
        return self.emotionArray.count + 1;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HWImageCell* imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    if (self.emotionArray.count == indexPath.row) {
        [imageCell.imageButton setTitle:NULL forState:UIControlStateNormal];
        [imageCell.imageButton setImage:[[UIImage imageNamed:@"keyboard_emotion_delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    } else {
        [imageCell.imageButton setImage:NULL forState:UIControlStateNormal];
        [imageCell.imageButton setTitle:self.emotionArray[indexPath.row] forState:UIControlStateNormal];
    }
    return imageCell;
}
@end
