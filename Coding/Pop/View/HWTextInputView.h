//
//  HWTextInputView.h
//  Coding
//
//  Created by 黄文海 on 2018/5/16.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWTextInputView : UITextView
@property(nonatomic, copy)NSString*placeHolder;


- (instancetype)initInputViewWithFrame:(CGRect)frame andPlaceHolder:(NSString*)placeHolder;

- (instancetype)initInputViewWithFrame:(CGRect)frame;

@end
