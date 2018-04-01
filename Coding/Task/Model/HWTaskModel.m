//
//  HWTaskModel.m
//  Coding
//
//  Created by 黄文海 on 2018/3/27.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWTaskModel.h"
@implementation User
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"userId":@"id"
             };
}
@end

@implementation Task
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"messageId":@"id",
             @"user":@"owner"
             };
}
@end

@implementation HWTaskModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"list":@"Task"
             };
}

@end
