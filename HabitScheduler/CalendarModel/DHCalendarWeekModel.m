//
//  DHCalendarWeekModel.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHCalendarWeekModel.h"

@implementation DHCalendarWeekModel

+ (NSString*)descriptionAtIndex:(NSInteger)index
{
    if (index == 0) {
        return NSLocalizedString(@"일", @"");
    }
    else if (index == 1) {
        return NSLocalizedString(@"월", @"");
    }
    else if (index == 2) {
        return NSLocalizedString(@"화", @"");
    }
    else if (index == 3) {
        return NSLocalizedString(@"수", @"");
    }
    else if (index == 4) {
        return NSLocalizedString(@"목", @"");
    }
    else if (index == 5) {
        return NSLocalizedString(@"금", @"");
    }
    else if (index == 6) {
        return NSLocalizedString(@"토", @"");
    }
    else {
        return @"-";
    }
}

@end
