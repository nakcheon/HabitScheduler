//
//  DHCalendarDayModel.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHCalendarDayModel.h"
#import "DHCalendarUtilityForDate.h"

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

/******************************************************************************************
 * Implementation
 ******************************************************************************************/
@implementation DHCalendarDayModel

+ (NSString*)descriptionWithYear:(NSString*)year
                       withMonth:(NSString*)month
                         atIndex:(NSInteger)index
{
    // 주어진 연, 월의 1일의 요일 찾기
    NSInteger indexOfFirstDay = [DHCalendarUtilityForDate getIndexOfWeekWithYear:year
                                                                       withMonth:month
                                                                         withDay:@"01"] - 1;
    
    // 찾은 요일로 인덱스를 구하기
    NSInteger day = index - indexOfFirstDay + 1/*0일이 없으므로 1을 추가*/;
    
    // 이전달, 다음달 검사 시작
    NSInteger daysInCurrentMonth = [DHCalendarUtilityForDate getNumberOfDaysWithYear:year
                                                                           withMonth:month
                                                                             withDay:@"01"];
    NSInteger daysInPreviousMonth = [DHCalendarUtilityForDate getNumberOfDaysWithYear:[DHCalendarUtilityForDate getPreviousYear:year withMonth:month]
                                                                            withMonth:[DHCalendarUtilityForDate getPreviousMonth:month]
                                                                              withDay:@"01"];
    
    // 이전 달일 경우
    if (day <= 0) {
        day = daysInPreviousMonth + day;
    }
    // 다음 달일 경우
    else if (day > daysInCurrentMonth) {
        day = day - daysInCurrentMonth;
    }
    
    return [NSString stringWithFormat:@"%d", day];
}

@end
