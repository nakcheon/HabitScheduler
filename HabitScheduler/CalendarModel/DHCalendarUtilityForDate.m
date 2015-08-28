//
//  DHCalendarUtilityForDate.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHCalendarUtilityForDate.h"
#import "DHCalendarDefine.h"

#pragma mark - enum Definition

/******************************************************************************
 * enum Definition
 *****************************************************************************/


/******************************************************************************
 * String Definition
 *****************************************************************************/


/******************************************************************************
 * Constant Definition
 *****************************************************************************/


/******************************************************************************
 * Type Definition
 *****************************************************************************/

@interface DHCalendarUtilityForDate(PrivateMethod)
// Private Methods
- (NSString *)privateGetDateWithDateFormat:(NSString *)format;
- (NSInteger)privateGetDayOfWeek;
@end

/******************************************************************************************
 * Implementation
 ******************************************************************************************/
@implementation DHCalendarUtilityForDate

#pragma mark - operation for today

/*
 MARK: Name -> privateGetDateWithDateFormat:
 MARK: 입력받은 형식으로 오늘의 날짜를 리턴한다.
 MARK: Param -> Format:(NSString *)format
 MARK: Return -> NSString
 */
- (NSString *)privateGetDateWithDateFormat:(NSString *)format
{
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
}


/*\
 MARK: Name -> getToday
 MARK: 오늘의 날짜를 리턴한다.
 MARK: Param
 MARK: Return -> NSString
 */
+ (NSString *)getToday
{
    DHCalendarUtilityForDate *selfObject = [[DHCalendarUtilityForDate alloc] init];
    return [selfObject privateGetDateWithDateFormat:@"dd"];
}


/*
 MARK: Name -> getTodayMonth
 MARK: 이번 '달'을 리턴한다.
 MARK: Param
 MARK: Return -> NSString
 */
+ (NSString *)getTodayMonth
{
    DHCalendarUtilityForDate *selfObject = [[DHCalendarUtilityForDate alloc] init];
    return [selfObject privateGetDateWithDateFormat:@"MM"];
}


/*
 MARK: Name -> getTodayYear
 MARK: 올해 년도를 리턴한다.
 MARK: Param
 MARK: Return -> NSString
 */
+ (NSString *)getTodayYear
{
    DHCalendarUtilityForDate *selfObject = [[DHCalendarUtilityForDate alloc] init];
    return [selfObject privateGetDateWithDateFormat:@"yyyy"];
}

#pragma mark - operation for given day

/*
 MARK: 주어진 일에 대한 요일을 리턴한다.
 MARK: Param
 MARK: Return -> NSInteger (1:일요일/2:월요일/3:화요일/4:수요일/5:목요일/6:금요일/7:토요일)
 */
+ (NSInteger)getIndexOfWeekWithYear:(NSString*)year
                          withMonth:(NSString*)month
                            withDay:(NSString*)day
{
    NSString* dateString = [NSString stringWithFormat:@"%@/%@/%@", month, day, year];
    NSDateFormatter* firstDateFormatter = [[NSDateFormatter alloc] init];
    [firstDateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate* date = [firstDateFormatter dateFromString:dateString];
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* weekDayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    return [weekDayComponents weekday];
}

/*
 MARK: 주어진 달에 대한 날짜수를 리턴한다.
 */
+ (NSInteger)getNumberOfDaysWithYear:(NSString*)year
                           withMonth:(NSString*)month
                             withDay:(NSString*)day
{
    NSString* dateString = [NSString stringWithFormat:@"%@/%@/%@", month, day, year];
    NSDateFormatter* firstDateFormatter = [[NSDateFormatter alloc] init];
    [firstDateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate* date = [firstDateFormatter dateFromString:dateString];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    
    return numberOfDaysInMonth;
}

/*
 MARK: 현재 달에서 한달뺐을때의 연도를 리턴한다.
 */
+ (NSString*)getPreviousYear:(NSString*)year
                   withMonth:(NSString*)month
{
    NSInteger currentYear = [year integerValue];
    NSInteger currentMonth = [month integerValue];
    --currentMonth;
    if (currentMonth < 1) {
        currentMonth = NUM_OF_MONTHS;
        --currentYear;
    }
    return [NSString stringWithFormat:@"%d", currentYear];
}

/*
 MARK: 현재 달에서 한달뺐을때의 달을 리턴한다.
 */
+ (NSString*)getPreviousMonth:(NSString*)month
{
    NSInteger currentMonth = [month integerValue];
    --currentMonth;
    if (currentMonth < 1) {
        currentMonth = NUM_OF_MONTHS;
    }
    return [NSString stringWithFormat:@"%d", currentMonth];
}

@end
