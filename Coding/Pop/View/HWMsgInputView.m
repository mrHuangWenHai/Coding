//
//  HWMsgInputView.m
//  Coding
//
//  Created by 黄文海 on 2018/5/16.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWMsgInputView.h"
#import "PopHeader.h"
#import "UIView+Frame.h"
#import "HWTextInputView.h"
#import "HWEmotionKeyboardView.h"


@interface HWMsgInputView()<UITextViewDelegate>
@property(nonatomic, strong)HWTextInputView* inputView;
@property(nonatomic, strong)UIButton* emojiButton;
@property(nonatomic, strong)UIView* contentView;
@property(nonatomic, strong)UIScrollView* scrollView;
@property(nonatomic, assign)CGFloat keyboardHeight;
@property(nonatomic, strong)HWEmotionKeyboardView* emotionKeyboard;
@end

@implementation HWMsgInputView
+ (instancetype)messageInputViewWithType:(HWMessageInputViewContentType)type {
    
    HWMsgInputView* megInputView = [[HWMsgInputView alloc] initWithFrame:CGRectMake(0, kScreen_Height + kMessageInputView_Height, kScreen_Width, kMessageInputView_Height)];
    
    [[NSNotificationCenter defaultCenter] addObserver:megInputView selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:megInputView selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    return megInputView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _emojiButton = [[UIButton alloc] init];
    [_emojiButton setImage:[UIImage imageNamed:@"keyboard_emotion"] forState:UIControlStateNormal];
    [_emojiButton addTarget:self action:@selector(emojiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_emojiButton];
    
    _contentView = [[UIView alloc] init];
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.cornerRadius = kMessageInputView_Height / 2 - 10;
    self.contentView.layer.masksToBounds = true;
    [self addSubview:_contentView];
    
    _inputView = [[HWTextInputView alloc] initInputViewWithFrame:CGRectZero andPlaceHolder:@"撰写评论"];
    _inputView.textContainerInset = UIEdgeInsetsMake(5, 0, 0, 0);
    _inputView.font = [UIFont systemFontOfSize:16];
    _inputView.returnKeyType = UIReturnKeySend;
    _inputView.scrollsToTop = NO;
    [self addSubview:_inputView];

}

- (void)layoutSubviews {
    CGFloat imageWidth = 35;
    CGFloat topSpare = 7.5;
    CGFloat leftSpare = 8;
 //   CGFloat height = CGRectGetHeight(self.frame);
    self.contentView.frame = CGRectMake(leftSpare, topSpare, kScreen_Width - leftSpare - imageWidth, kMessageInputView_Height - 2 * topSpare);
    self.inputView.frame = CGRectMake(leftSpare + 10, topSpare + 3, kScreen_Width - imageWidth - leftSpare - 20, imageWidth - 6);
    self.emojiButton.frame = CGRectMake(self.contentView.getX, topSpare, imageWidth, imageWidth);
}

- (void)emojiButtonClick:(id)sender {
    [self.inputView resignFirstResponder];

}

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSNumber* aValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    self.keyboardHeight = endFrame.size.height;
    [UIView animateWithDuration:aValue.floatValue animations:^{
        self.frame = CGRectMake(0, kScreen_Height - self.keyboardHeight - CGRectGetHeight(self.frame), kScreen_Width, CGRectGetHeight(self.frame));
    }];

}

- (void)keyboardDidHide:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (self.emotionKeyboard == NULL) {
        
        NSArray* imageArray = NULL;
        if ([self.deleage respondsToSelector:@selector(getButtonImageArray)]) {
            imageArray = [self.deleage getButtonImageArray];
        }
        _emotionKeyboard = [[HWEmotionKeyboardView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kKeyboardView_Height) andImageArray:imageArray];
    }
    ((UIViewController*)self.deleage).tabBarController.tabBar.hidden = true;
    self.emotionKeyboard.frame = CGRectMake(0, kMessageInputView_Height + kKeyboardView_Height, kScreen_Width, kKeyboardView_Height);
    [self addSubview:self.emotionKeyboard];
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, kScreen_Height - (kMessageInputView_Height + kKeyboardView_Height), kScreen_Width, kMessageInputView_Height + kKeyboardView_Height);
        self.emotionKeyboard.frame = CGRectMake(0, kMessageInputView_Height, kScreen_Width, kKeyboardView_Height);
    }];
}

- (void)sendWithMessage:(NSString*)message {
    
}

- (void)showMsgInputView {
    [self.inputView becomeFirstResponder];
}



@end
