//
//  MessageModel.h
//  Coding
//
//  Created by 黄文海 on 2018/5/6.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detail : NSObject
@property(nonatomic, assign)NSUInteger kId;
@property(nonatomic, copy)NSString* global_key;
@property(nonatomic, copy)NSString* name;
@property(nonatomic, copy)NSString* avatar;
@end

@interface Message : NSObject
@property(nonatomic, assign)NSUInteger kId;
@property(nonatomic, strong)Detail* sender;
@property(nonatomic, strong)Detail* fri;
@property(nonatomic, assign)NSUInteger count;
@property(nonatomic, assign)NSUInteger unreadCount;
@property(nonatomic, assign)NSUInteger created_at;
@property(nonatomic, assign)NSUInteger read_at;
@property(nonatomic, assign)NSUInteger status;
@property(nonatomic, assign)NSUInteger type;
@property(nonatomic, copy)NSString* content;
@end

@interface MessageModel:NSObject
@property(nonatomic, copy)NSArray* list;
@property(nonatomic, assign)NSUInteger page;
@property(nonatomic, assign)NSUInteger pageSize;
@property(nonatomic, assign)NSUInteger totalPage;
@property(nonatomic, assign)NSUInteger totalRow;
@end
