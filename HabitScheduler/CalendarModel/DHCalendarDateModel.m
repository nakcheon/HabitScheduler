//
//  DHCalendarDateModel.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHCalendarDateModel.h"

@implementation DHCalendarDateModel

+ (NSString*)descriptionWithYear:(NSString*)year
                       withMonth:(NSString*)month
{
    NSString* yearMonth = [NSString stringWithFormat:@"%@%@ %@%@",
                           year, NSLocalizedString(@"년", @""),
                          month, NSLocalizedString(@"월", @"")];
    return yearMonth;
}

@end
