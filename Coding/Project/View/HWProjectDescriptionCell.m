//
//  HWProjectDescriptionCell.m
//  Coding
//
//  Created by 黄文海 on 2018/3/17.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWProjectDescriptionCell.h"
@interface HWProjectDescriptionCell()
@property(nonatomic, strong)CALayer* lineLayer;
@end

@implementation HWProjectDescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lineLayer = [[CALayer alloc] init];
        _lineLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dot_line"]].CGColor;
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:15];
        _descriptionLabel.numberOfLines = 0;
        [self.contentView addSubview:_descriptionLabel];
        [self.contentView.layer addSublayer:_lineLayer];
        
    }
    return self;
}

- (void)layoutSubviews {
    CGRect bounds = self.contentView.bounds;
    self.lineLayer.frame = CGRectMake(8, 0, bounds.size.width, 1);
    self.descriptionLabel.frame = CGRectMake(8, 1, bounds.size.width - 16, bounds.size.height - 1);
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
