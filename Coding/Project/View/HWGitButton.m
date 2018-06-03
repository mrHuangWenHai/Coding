//
//  HWGitButton.m
//  Coding
//
//  Created by 黄文海 on 2018/5/25.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWGitButton.h"
#import "UIColor+Expanded.h"

@interface HWGitButton()
@property(nonatomic, strong)UIButton* leftButton;
@property(nonatomic, strong)UIButton* rightButton;
@property(nonatomic, strong)CALayer* lineLayer;
@property(nonatomic, assign)GitButtonType type;
@end

@implementation HWGitButton
- (instancetype)initWithButtonType:(GitButtonType)buttonType{
    self = [super init];
    if (self) {
        _check = false;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2.0;
        self.layer.borderWidth = 2;
        _type = buttonType;
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitleColor:[UIColor colorWithHexString:@"0x425063"] forState:UIControlStateNormal];
        switch (_type) {
            case Fork:
                [_leftButton setTitle:@"Fork" forState:UIControlStateNormal];
                [_leftButton setImage:[UIImage imageNamed:@"git_icon_fork"] forState:UIControlStateNormal];
                break;
            case Watch:
                [_leftButton setTitle:@"关注" forState:UIControlStateNormal];
                [_leftButton setImage:[UIImage imageNamed:@"git_icon_watch"] forState:UIControlStateNormal];
                break;
            case Star:
                [_leftButton setTitle:@"收藏" forState:UIControlStateNormal];
                [_leftButton setImage:[UIImage imageNamed:@"git_icon_star"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
        
        [_leftButton addTarget:self action:@selector(gitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        
        _rightButton = [[UIButton alloc] init];
        [_rightButton setTitleColor:[UIColor colorWithHexString:@"0x425063"] forState:UIControlStateNormal];
        [_rightButton setTitle:@"0" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_rightButton];
        
        _lineLayer = [[CALayer alloc] init];
        _lineLayer.backgroundColor = [UIColor colorWithHexString:@"0xA9B3BE"].CGColor;
        [self.layer addSublayer:_lineLayer];
        
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    self.leftButton.frame = CGRectMake(0, 0, width / 5 * 3 - 1, height);
    self.lineLayer.frame = CGRectMake(width / 5 * 3 - 1, (height - 16) / 2, 1, 16);
    self.rightButton.frame = CGRectMake(width / 5 * 3, 0, width / 5 * 2, height);
}

- (void)gitButtonClick:(UIButton*)gitButton {
    NSString* title = self.rightButton.titleLabel.text;
    if ([title isEqualToString:@"1"]) {
        title = @"0";
    } else {
        title = @"1";
    }
    [self setContentOfButton:title];
}

- (void)setSelectBackGroundColor {
    switch (self.type) {
        case Fork:
            self.backgroundColor = [UIColor colorWithHexString:@"0xD8DDE4"];
            break;
        case Watch:
            self.backgroundColor = [UIColor colorWithHexString:@"0x4F95E8"];
            [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case Star:
            self.backgroundColor = [UIColor colorWithHexString:@"0x425063"];
            [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)setContentOfButton:(NSString*)title {
    if ([title isEqualToString:@"1"]) {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        [self setSelectBackGroundColor];
    } else {
        self.layer.borderColor = [UIColor colorWithHexString:@"0xD8DDE4"].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        [self.leftButton setTitleColor:[UIColor colorWithHexString:@"0x425063"] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor colorWithHexString:@"0x425063"] forState:UIControlStateNormal];

    }
    [self.rightButton setTitle:title forState:UIControlStateNormal];
}
@end
