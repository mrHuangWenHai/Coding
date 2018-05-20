//
//  HWMsgInputView.h
//  Coding
//
//  Created by 黄文海 on 2018/5/16.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HWMessageInputViewContentType) {
    HWMessageInputContentTypePop = 0
};

@protocol HWMessageInputViewContentDelegate <NSObject>
- (void)sendWithMessage:(NSString*)message;
- (NSArray*)getButtonImageArray;
@end

@interface HWMsgInputView : UIView
@property(nonatomic, weak)id<HWMessageInputViewContentDelegate>deleage;
+ (instancetype)messageInputViewWithType:(HWMessageInputViewContentType)type;
- (void)showMsgInputView;
@end
