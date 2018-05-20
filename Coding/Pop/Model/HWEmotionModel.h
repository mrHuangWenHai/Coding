//
//  HWEmotionModel.h
//  Coding
//
//  Created by 黄文海 on 2018/5/18.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWEmotionModel : NSObject

@property(nonatomic, copy)NSDictionary* emojis;

- (NSArray*)getEmotionWithEmotionName:(NSString*)emotionName andPageNum:(NSInteger)pageNum;
- (NSArray*)getEmotionArrayWithIndex:(NSInteger)index;
@end
