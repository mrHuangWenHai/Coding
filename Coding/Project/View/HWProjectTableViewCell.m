//
//  HWProjectTableViewCell.m
//  Coding
//
//  Created by 黄文海 on 2018/3/14.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWProjectTableViewCell.h"
#import "UIColor+Expanded.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation HWProjectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProject:(Project *)project {
    
    self.projectLabel.text = project.name;
    self.descriptionLabel.text = project.des;
    self.descriptionLabel.textColor = [UIColor colorWithHexString:@"0x76808E"];
    self.ownerUserNameLabel.text = project.ownerUserName;
    self.ownerUserNameLabel.textColor = [UIColor colorWithHexString:@"0xA9B3BE"];
    self.rightUtilityButtons = [self rightButtonsWithProjects:project];
    NSString* urlString = NULL;
    if ([project.icon hasPrefix:@"http"]) {
        urlString = project.icon;
    } else {
        urlString = [NSString stringWithFormat:@"https://coding.net%@",project.icon];
    }
    
    if (project.pin) {
        self.pinImageView.hidden = false;
    } else {
        self.pinImageView.hidden = true;
    }
    [self.projectImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"logo_coding"]];
}

- (NSArray *)rightButtonsWithProjects:(Project*)project {
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    UIColor* buttonColor;
    UIColor* titleColor;
    NSString* title;
    if (project.pin) {
        buttonColor = [UIColor colorWithHexString:@"0xF2F4F6"];
        titleColor = [UIColor colorWithHexString:@"0x0060FF"];
        title = @"取消常用";
    } else {
        buttonColor = [UIColor colorWithHexString:@"0x0060FF"];
        titleColor = [UIColor whiteColor];
        title = @"设置常用";
    }
    
    NSAttributedString* titleString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:titleColor}];
    [rightUtilityButtons sw_addUtilityButtonWithColor:buttonColor attributedTitle:titleString];
    
    return rightUtilityButtons;
}

@end
