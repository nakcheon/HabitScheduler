//
//  DHCalendarHeaderCell.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHCalendarHeaderCell.h"

@implementation DHCalendarHeaderCell
@dynamic yearMonth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - IBAction methods

- (IBAction)previousMonthButtonPressed:(id)sender
{
    if (self.delegate) {
        [self.delegate CalendarControlMoveToPreviousMonth];
    }
}

- (IBAction)nextMonthButtonPressed:(id)sender
{
    if (self.delegate) {
        [self.delegate CalendarControlMoveToNextMonth];
    }
}

#pragma mark - setter/getter

- (void)setYearMonth:(NSString *)yearMonth
{
    _labelYearMonth.text = yearMonth;
}

- (NSString*)yearMonth
{
    return _labelYearMonth.text;
}

@end
