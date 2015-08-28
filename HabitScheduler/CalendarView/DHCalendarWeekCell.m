//
//  DHClaendarWeekCell.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHCalendarWeekCell.h"

@implementation DHCalendarWeekCell
@dynamic week;
@dynamic weekType;

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

#pragma mark - overrides

- (void)prepareForReuse
{
    _labelWeek.text = @"";
    _labelWeek.textColor = [UIColor blackColor];
}

#pragma mark - setter/getter

// week
- (void)setWeek:(NSString *)week
{
    _labelWeek.text = week;
}

- (NSString*)day
{
    return _labelWeek.text;
}

// weekType
- (void)setWeekType:(WeekType)weekType
{
    if (weekType == kFirstDay) {
        _labelWeek.textColor = [UIColor redColor];
    }
    else if (weekType == kLastDay) {
        _labelWeek.textColor = [UIColor blueColor];
    }
    else if (weekType == kWeekDays) {
        _labelWeek.textColor = [UIColor blackColor];
    }
    else {
        // do nothing
    }
}

- (WeekType)weekType
{
    WeekType retType = kWeekDays;
    if ([_labelWeek.textColor isEqual:[UIColor redColor]]) {
        retType = kFirstDay;
    }
    else if ([_labelWeek.textColor isEqual:[UIColor blueColor]]) {
        retType = kLastDay;
    }
    else if ([_labelWeek.textColor isEqual:[UIColor blackColor]]) {
        retType = kWeekDays;
    }
    else {
        // do nothing
    }
    
    return retType;
}

@end
