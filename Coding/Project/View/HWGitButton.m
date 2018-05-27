//
//  HWGitButton.m
//  Coding
//
//  Created by 黄文海 on 2018/5/25.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWGitButton.h"

@interface HWGitButton()
@property(nonatomic, strong)UIButton* gitButton;
@property(nonatomic, strong)UILabel* gitLabel;
@property(nonatomic, assign)GitButtonType type;
@end

@implementation HWGitButton
- (instancetype)initWithFrame:(CGRect)frame andButtonType:(GitButtonType)buttonType{
    self = [super initWithFrame:frame];
    if (self) {
        _type = buttonType;
        _gitButton = [[UIButton alloc] init];
        switch (_type) {
            case Fork:
                [_gitButton setTitle:@"Fork" forState:UIControlStateNormal];
                [_gitButton setImage:[UIImage imageNamed:@"git_icon_fork"] forState:UIControlStateNormal];
                break;
            case Watch:
                [_gitButton setTitle:@"关注" forState:UIControlStateNormal];
                [_gitButton setImage:[UIImage imageNamed:@"git_icon_watch"] forState:UIControlStateNormal];
                break;
            case Star:
                [_gitButton setTitle:@"收藏" forState:UIControlStateNormal];
                [_gitButton setImage:[UIImage imageNamed:@"git_icon_star"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        [_gitButton addTarget:self action:@selector(gitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_gitButton];
        
        _gitLabel = [[UILabel alloc] init];
        
        
        
    }
    return self;
}

- (void)gitButtonClick:(UIButton*)gitButton {
    
}
@end
