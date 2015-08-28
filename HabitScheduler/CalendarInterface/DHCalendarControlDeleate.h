//
//  DHCalendarControlDeleate.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHCalendarControlDeleate <NSObject>

- (void)CalendarControlMoveToPreviousMonth;
- (void)CalendarControlMoveToNextMonth;

@end
