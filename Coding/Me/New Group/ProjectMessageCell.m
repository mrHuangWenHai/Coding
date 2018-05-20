//
//  ProjectMessageCell.m
//  Coding
//
//  Created by 黄文海 on 2018/5/12.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "ProjectMessageCell.h"
#import "UIColor+Expanded.h"
#import "UIView+Frame.h"
#import "MeHeader.h"

@interface ProjectMessageCell()
@property(nonatomic, strong)UILabel* privateLabel;
@property(nonatomic, strong)UILabel* publicLabel;
@property(nonatomic, strong)UIButton* leftButton;
@property(nonatomic, strong)UIButton* rightButon;
@property(nonatomic, strong)CALayer* spareLayer;
@end

@implementation ProjectMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    _privateMessageLabel = [[UILabel alloc] init];
    _privateMessageLabel.font = [UIFont systemFontOfSize:16];
    _privateMessageLabel.textColor = [UIColor colorWithString:@"0x323A45"];
    _privateMessageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_privateMessageLabel];
    
    _privateLabel = [[UILabel alloc] init];
    _privateLabel.font = [UIFont systemFontOfSize:12];
    _privateLabel.textColor = [UIColor colorWithString:@"0x76808E"];
    _privateLabel.textAlignment = NSTextAlignmentCenter;
    _privateLabel.text = @"私有";
    [self addSubview:_privateLabel];
    
    _publiceMessageLabel = [[UILabel alloc] init];
    _publiceMessageLabel.font = [UIFont systemFontOfSize:16];
    _publiceMessageLabel.textColor = [UIColor colorWithString:@"0x323A45"];
    _publiceMessageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_publiceMessageLabel];
    
    _publicLabel = [[UILabel alloc] init];
    _publicLabel.font = [UIFont systemFontOfSize:12];
    _publicLabel.textColor = [UIColor colorWithString:@"0x76808E"];
    _publicLabel.textAlignment = NSTextAlignmentCenter;
    _publicLabel.text = @"共有";
    [self addSubview:_publicLabel];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftButton];
    
    _rightButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButon addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightButon];
    
    _spareLayer = [[CALayer alloc] init];
    _spareLayer.backgroundColor = kColorD8DDE4.CGColor;
    [self.layer addSublayer:_spareLayer];
    
}

- (void)layoutSubviews {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat top = 5;
    
    _privateMessageLabel.frame = CGRectMake(0, top, width/2 - 1, height/2);
    _privateLabel.frame = CGRectMake(0, _privateMessageLabel.getY, width/2-1, height/2);
    _publiceMessageLabel.frame = CGRectMake(width/2+1, top, width/2 -1, height/2);
    _publicLabel.frame = CGRectMake(width/2+1, _publiceMessageLabel.getY, width/2-1, height/2);
    
    _leftButton.frame = CGRectMake(0, 0, width/2-1, height);
    _rightButon.frame = CGRectMake(_leftButton.getX+1, 0, width/2-1, height);
    
    _spareLayer.frame = CGRectMake(width/2 - 1, 10, 1, height - 20);
}

- (void)leftButtonAction {
    
}

- (void)rightButtonAction {
    
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
