//
//  DHCalendarDefine.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#ifndef DHCalendarTest_DHCalendarDefine_h
#define DHCalendarTest_DHCalendarDefine_h

/******************************************************************************
 * enum Definition
 *****************************************************************************/
typedef NS_ENUM(NSUInteger, WeekType) {
    kFirstDay,/*sunday*/
    kLastDay,/*satursday*/
    kWeekDays,
};

typedef NS_ENUM(NSUInteger, MonthType) {
    kPreviousMonth,
    kCurrentMonth,
    kNextMonth,
};

/******************************************************************************
 * String Definition
 *****************************************************************************/
#define NUM_OF_WEEK_DAYS 7
#define NUM_OF_MONTHS 12

/******************************************************************************
 * Constant Definition
 *****************************************************************************/


/******************************************************************************
 * Type Definition
 *****************************************************************************/

#endif
