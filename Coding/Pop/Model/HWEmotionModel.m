//
//  HWEmotionModel.m
//  Coding
//
//  Created by 黄文海 on 2018/5/18.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWEmotionModel.h"

@implementation HWEmotionModel

- (NSDictionary*)emojis {
    if (_emojis == NULL) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"emotion_list"
                                                              ofType:@"plist"];
        _emojis = [[NSDictionary dictionaryWithContentsOfFile:plistPath] copy];
    }
    return _emojis;
}

- (NSArray*)getEmotionWithEmotionName:(NSString*)emotionName andPageNum:(NSInteger)pageNum {
    NSMutableArray* emotionArray = self.emojis[emotionName];
    return [emotionArray subarrayWithRange:NSMakeRange(pageNum * 20, 20)];
}

- (NSArray*)getEmotionArrayWithIndex:(NSInteger)index {
    NSArray* allKeys = self.emojis.allKeys;
    if (index >= allKeys.count) {
        return NULL;
    } else {
        return [self.emojis objectForKey:allKeys[index]];
    }
}

@end
