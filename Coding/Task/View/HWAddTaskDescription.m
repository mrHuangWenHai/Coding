//
//  HWAddTaskDescription.m
//  Coding
//
//  Created by 黄文海 on 2018/3/30.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWAddTaskDescription.h"
#import "UIView+Frame.h"
#import "UIColor+Expanded.h"
#import "HWProjectModel.h"
#import "HWTaskModel.h"
#import "NSDate+Common.h"

@interface HWAddTaskDescription()
@property(nonatomic, strong)UITextView* descriptionTextView;
@property(nonatomic, strong)UILabel* userLabel;
@property(nonatomic, strong)UIButton* addDescriptionButton;

@end

@implementation HWAddTaskDescription

- (instancetype)initWithType:(TaskStatus)status {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _addLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* image = [UIImage imageNamed:@"project_tag_icon"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_addLabelButton setImage:image forState:UIControlStateNormal];
        [_addLabelButton setTitle:@"添加标签" forState:UIControlStateNormal];
      
        [_addLabelButton setTitleColor:[UIColor colorWithRed:19/255.0 green:107/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
        _addDescriptionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addDescriptionButton.layer.cornerRadius = 2;
        _addDescriptionButton.layer.masksToBounds = true;
        _addDescriptionButton.backgroundColor = [UIColor colorWithHexString:@"0xFFFFFF"];
        [_addDescriptionButton setImage:[UIImage imageNamed:@"task_icon_arrow"] forState:UIControlStateNormal];
        _addDescriptionButton.backgroundColor = [UIColor colorWithRed:242/255.0 green:244/255.0 blue:246/255.0 alpha:1];
        [_addDescriptionButton setTitle:@"添加描述" forState:UIControlStateNormal];
        [_addDescriptionButton setTitleColor:[UIColor colorWithHexString:@"0x425063"] forState:UIControlStateNormal];
        _addDescriptionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        _addDescriptionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 90, 0, -90);
        _userLabel = [[UILabel alloc] init];
        _userLabel.textColor = [UIColor colorWithHexString:@"0x76808E"];
        _userLabel.font = [UIFont systemFontOfSize:14];
        _descriptionTextView = [[UITextView alloc] init];
        _descriptionTextView.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:_addLabelButton];
        [self addSubview:_addDescriptionButton];
        [self addSubview:_userLabel];
        [self addSubview:_descriptionTextView];
    }
    return self;
}

- (void)layoutSubviews {
    
    CGFloat widht = CGRectGetWidth(self.bounds);
    CGFloat top = 10;
    CGFloat leftSpare = 6;
    CGFloat addLabelHeight = 30;//40+10+100 + 40 +40
    _addLabelButton.frame = CGRectMake(leftSpare, top, widht/4, addLabelHeight);
    _descriptionTextView.frame = CGRectMake(5, _addLabelButton.getY + top, widht - 10, 100);
    _userLabel.frame = CGRectMake(leftSpare, _descriptionTextView.getY + top, widht - 2*leftSpare, 30);
    _addDescriptionButton.frame = CGRectMake(leftSpare, _userLabel.getY, widht - 2*leftSpare, 30);
}

- (void)setProjectModel:(HWProjectModel *)projectModel {
    _projectModel = projectModel;
    Project* project = projectModel.list[0];
    _userLabel.text = [NSString stringWithFormat:@"%@ 现在",project.ownerUserName];
}

- (void)setTask:(Task *)task {
    
    _task = task;
    NSMutableString* des = [NSMutableString stringWithFormat:@"#1 %@ 创建于 ",_task.user.name];
    NSTimeInterval time = (double)_task.created_at / 1000;
    NSDate *createAtTime=[NSDate dateWithTimeIntervalSince1970:time];
    NSString *timeString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[createAtTime stringDisplay_HHmm]]];
    [des appendString:timeString];
    _userLabel.text = des;
    _descriptionTextView.text = _task.content;
}

@end
