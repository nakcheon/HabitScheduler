//
//  DHCalendarUtilityForDate.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHCalendarUtilityForDate : NSObject
// today
+ (NSString *)getToday;
+ (NSString *)getTodayMonth;
+ (NSString *)getTodayYear;

// given day
+ (NSInteger)getIndexOfWeekWithYear:(NSString*)year
                          withMonth:(NSString*)month
                            withDay:(NSString*)day;
+ (NSInteger)getNumberOfDaysWithYear:(NSString*)year
                           withMonth:(NSString*)month
                             withDay:(NSString*)day;
+ (NSString*)getPreviousYear:(NSString*)year
                   withMonth:(NSString*)month;
+ (NSString*)getPreviousMonth:(NSString*)month;
@end
