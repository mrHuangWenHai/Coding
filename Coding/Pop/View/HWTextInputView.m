//
//  HWTextInputView.m
//  Coding
//
//  Created by 黄文海 on 2018/5/16.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWTextInputView.h"

@interface HWTextInputView()<UITextViewDelegate>
@property(nonatomic, strong)UILabel* placeHolderLabel;
@end

@implementation HWTextInputView

- (instancetype)initInputViewWithFrame:(CGRect)frame {
   return [self initInputViewWithFrame:frame andPlaceHolder:nil];
}

- (instancetype)initInputViewWithFrame:(CGRect)frame andPlaceHolder:(NSString *)placeHolder {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeHolder = placeHolder;
        self.delegate = self;
    }
    return self;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    if (placeHolder == NULL || [placeHolder isEqualToString:@""]) {
        return ;
    }
    self.placeHolderLabel.text = placeHolder;
    [self.placeHolderLabel sizeToFit];
}

- (UILabel*)placeHolderLabel {
    if (_placeHolderLabel == NULL) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_placeHolderLabel];
    }
    return _placeHolderLabel;
}

- (void)layoutSubviews {
    if (_placeHolderLabel) {
        UIEdgeInsets insets = self.textContainerInset;
        self.placeHolderLabel.frame = CGRectMake(insets.left + 5, insets.top, CGRectGetWidth(self.bounds) - (insets.left + insets.right + 5), CGRectGetHeight(_placeHolderLabel.frame));
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length != 0) {
        self.placeHolderLabel.hidden = true;
    } else {
        self.placeHolderLabel.hidden = NO;
    }
}
@end
