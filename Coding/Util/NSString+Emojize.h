//
//  NSString+Emojize.h
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emojize)
- (NSString *)emojizedString;
+ (NSString *)emojizedStringWithString:(NSString *)text;

- (NSString *)aliasedString;
+ (NSString *)aliasedStringWithString:(NSString *)text;

+ (NSDictionary *)emojiForAliases;
+ (NSDictionary *)aliaseForEmojis;

- (NSString *)toAliase;
- (NSString *)toEmoji;
@end
