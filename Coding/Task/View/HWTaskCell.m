//
//  HWTaskCell.m
//  Coding
//
//  Created by 黄文海 on 2018/3/26.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWTaskCell.h"
#import "UIView+Frame.h"
#import "HWTaskModel.h"
#import "UIImageView+Expanded.h"
#import "YYText.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+Expanded.h"
#import "NSDate+Common.h"


@interface HWTaskCell()
@property(nonatomic, strong)UIButton* selectButton;
@property(nonatomic, strong)UIImageView* taskImageView;
@property(nonatomic, strong)YYLabel* titleTaskLabel;
@property(nonatomic, strong)YYLabel* detailTaskLabel;
@end

@implementation HWTaskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    
    _selectButton = [[UIButton alloc] init];
    [_selectButton setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:UIControlStateNormal];
    [_selectButton addTarget:self action:@selector(selectTask:) forControlEvents:UIControlEventTouchUpInside];
    
    _taskImageView = [[UIImageView alloc] init];
    _titleTaskLabel = [[YYLabel alloc] init];
    _titleTaskLabel.font = [UIFont systemFontOfSize:15];
    _titleTaskLabel.textColor = [UIColor colorWithHexString:@"0x323A45"];
    _detailTaskLabel = [[YYLabel alloc] init];
    
    [self.contentView addSubview:_selectButton];
    [self.contentView addSubview:_taskImageView];
    [self.contentView addSubview:_titleTaskLabel];
    [self.contentView addSubview:_detailTaskLabel];
}

- (void)layoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
    CGFloat leftSpare = 8;
    CGFloat imageTop = height/2 - 20;
    CGFloat imageHeight = 40;
    CGFloat imageWidth = imageHeight;
    CGFloat titleTop = 10;
    CGFloat titleHeight = height/2 - titleTop - 3;
    
    self.selectButton.frame = CGRectMake(leftSpare, height/2 - 10, 20, 20);
    self.taskImageView.frame = CGRectMake(self.selectButton.getX + leftSpare, imageTop, imageWidth, imageHeight);
    self.titleTaskLabel.frame = CGRectMake(self.taskImageView.getX + leftSpare, titleTop, width - self.taskImageView.getX, titleHeight);
    self.detailTaskLabel.frame = CGRectMake(self.taskImageView.getX + leftSpare, self.titleTaskLabel.getY + 9,width - self.taskImageView.getX - leftSpare, 20);
    
}

- (void)setTask:(Task *)task {
    _task = task;
    NSURL* url = NULL;
    if ([_task.user.avatar hasPrefix:@"https"]) {
        url = [NSURL URLWithString:_task.user.avatar];
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://coding.net%@",_task.user.avatar]];
    }
    __weak typeof(self) weakself = self;
    [self.taskImageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakself.taskImageView setCornerRadius];
    }];
    
    UIFont* font = [UIFont systemFontOfSize:15];
    NSMutableAttributedString *titleText = [NSMutableAttributedString new];
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"taskPriority%ld_small",_task.priority]];
    image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
    NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    
    [titleText appendAttributedString:attachText];
    [titleText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",_task.content]]];
    self.titleTaskLabel.attributedText = titleText;
    
    NSMutableAttributedString* detailText = [[NSMutableAttributedString alloc] init];
    [detailText appendAttributedString:[[NSAttributedString alloc] initWithString:
                                        [NSString stringWithFormat:@"#%ld %@   ",(long)_task.number,_task.user.name]]];
    
    UIImage* timeImage = [UIImage imageNamed:@"time_clock_icon"];
    timeImage = [UIImage imageWithCGImage:timeImage.CGImage scale:2 orientation:UIImageOrientationUp];
    NSMutableAttributedString *clockText = [NSMutableAttributedString yy_attachmentStringWithContent:timeImage contentMode:UIViewContentModeCenter attachmentSize:timeImage.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [detailText appendAttributedString:clockText];
    
    NSTimeInterval time = (double)_task.created_at / 1000;
    NSDate *createAtTime=[NSDate dateWithTimeIntervalSince1970:time];
    NSAttributedString *timeString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@    ",[createAtTime stringDisplay_MMdd]]];
    [detailText appendAttributedString:timeString];
    
    UIImage *topicImage = [UIImage imageNamed:@"topic_comment_icon"];
    topicImage = [UIImage imageWithCGImage:topicImage.CGImage scale:2 orientation:UIImageOrientationUp];
    NSMutableAttributedString *topicText = [NSMutableAttributedString yy_attachmentStringWithContent:topicImage contentMode:UIViewContentModeCenter attachmentSize:topicImage.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [detailText appendAttributedString:topicText];
    
    NSAttributedString* comments = [[NSAttributedString alloc] initWithString:
                                    [NSString stringWithFormat:@"   %ld",_task.comments]];
    [detailText appendAttributedString:comments];
    [detailText yy_setColor:[UIColor colorWithHexString:@"0x76808E"] range:NSMakeRange(0, detailText.length)];
    
    self.detailTaskLabel.attributedText = detailText;
    
}

- (void)selectTask:(id)sender {
    static BOOL isSelect = false;
    if (isSelect) {
        [self.selectButton setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:UIControlStateNormal];
        isSelect = false;
    } else {
        [self.selectButton setImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateNormal];
        isSelect = true;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
