//
//  NSDate+ITTAdditions.h
//
//  Created by guo hua on 11-9-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DefaultDateFormat @"yyyy年MM月dd日"
#define DefaultDateSeparateLineFormat @"yyyy-MM-dd"

@interface NSDate(ITTAdditions)
+ (NSString *)timeStringWithInterval:(NSTimeInterval) time;
+ (NSDate *)dateWithString:(NSString *)str formate:(NSString *)formate;
+ (NSDate *)relativedDateWithInterval:(NSInteger)interval;

- (NSString *)stringWithSeperator:(NSString *)seperator;
- (NSString *)stringWithFormat:(NSString*)format;
- (NSString *)stringWithSeperator:(NSString *)seperator includeYear:(BOOL)includeYear;
- (NSDate *)relativedDateWithInterval:(NSInteger)interval ;
- (NSString *)weekday;
-(NSInteger) daysOfEndDate:(NSDate *)endDate;

@end