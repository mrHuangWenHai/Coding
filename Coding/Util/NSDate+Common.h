//
//  NSDate+Common.h
//  Coding
//
//  Created by 黄文海 on 2018/3/28.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Helper.h"
#import "NSDate+Convenience.h"

@interface NSDate (Common)

- (NSInteger)secondsAgo;
- (NSInteger)minutesAgo;
- (NSInteger)hoursAgo;
- (NSInteger)monthsAgo;
- (NSInteger)yearsAgo;
- (NSInteger)leftDayCount;


- (NSString *)string_yyyy_MM_dd_EEE;//@"yyyy-MM-dd EEE" + (今天/昨天)
- (NSString *)string_yyyy_MM_dd;//@"yyyy-MM-dd"
- (NSString *)stringDisplay_HHmm;//n秒前 / 今天 HH:mm
- (NSString *)stringDisplay_MMdd;//n庙前 / 今天 / MM/dd

+ (NSString *)convertStr_yyyy_MM_ddToDisplay:(NSString *)str_yyyy_MM_dd;//(今天、明天) / MM月dd日 / yyyy年MM月dd日

- (NSString *)stringTimesAgo;//代码更新时间

- (BOOL)isSameDay:(NSDate*)anotherDate;

+ (BOOL)isDuringMidAutumn;

@end
