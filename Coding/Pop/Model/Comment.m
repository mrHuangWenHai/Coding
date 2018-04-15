//
//  Comment.m
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "Comment.h"

@implementation Comment

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"uid":@"id"
             };
}
@end
