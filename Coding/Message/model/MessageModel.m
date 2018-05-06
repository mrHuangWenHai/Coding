//
//  MessageModel.m
//  Coding
//
//  Created by 黄文海 on 2018/5/6.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "MessageModel.h"
#import "HtmlMedia.h"


@implementation Detail
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"kId":@"id"
             };
}

@end


@implementation Message

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"kId":@"id",
             @"fri":@"friend"
             };
}

- (void)setContent:(NSString *)content {
    if (_content != content) {
        HtmlMedia* htmlMedia = [HtmlMedia htmlMediaWithString:content showType:MediaShowTypeCode];
        if (htmlMedia.contentDisplay.length <= 0 && htmlMedia.imageItems.count <= 0) {
            _content = @"    ";//占位
        }else{
            _content = htmlMedia.contentDisplay;
        }
    }
}

@end

@implementation MessageModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"list":@"Message"
             };
}
@end
