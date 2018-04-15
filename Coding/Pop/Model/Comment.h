//
//  Comment.h
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWTaskModel.h"

@class HtmlMedia;
typedef NS_ENUM(NSInteger, CommentSendType) {
    CommentSendTypeSuccess = 0,
    CommentSendTypeIng,
    CommentSendTypeFail
};

@interface Comment : NSObject
@property (readwrite, nonatomic, strong) NSString *content;
@property (readwrite, nonatomic, strong) User *owner;
@property (readwrite, nonatomic, assign) NSInteger uid, owner_id, tweet_id;
@property (readwrite, nonatomic, assign) NSInteger created_at;
@property (readwrite, nonatomic, strong) HtmlMedia *htmlMedia;

@end
