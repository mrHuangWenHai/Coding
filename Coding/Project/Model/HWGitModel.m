//
//  HWGitModel.m
//  Coding
//
//  Created by 黄文海 on 2018/6/2.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWGitModel.h"
#import "NSDate+Common.h"

@implementation GitMessage

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"gitId":@"id"
             };
}
@end

@implementation HWGitModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"data" : @"GitMessage"};
}

- (NSMutableArray*)dataGroup {
    
    if (!_dataGroup) {
        _dataGroup = [[NSMutableArray alloc] init];
        NSDate* lastDate = [NSDate dateWithTimeIntervalSince1970:0];
        NSMutableArray* samgeDay = NULL;
        for (GitMessage* gitMessage in self.data) {
            NSDate* date = [NSDate dateWithTimeIntervalSince1970:gitMessage.created_at / 1000];
            if ([lastDate isSameDay:date]) {
                [samgeDay addObject:date];
            } else {
                lastDate = date;
                if (samgeDay) {
                    [_dataGroup addObject:[samgeDay copy]];
                }
                samgeDay = [[NSMutableArray alloc] init];
                [samgeDay addObject:date];
            }
        }
        [_dataGroup addObject:[samgeDay copy]];
    }
    return _dataGroup;
}
@end
