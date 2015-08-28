//
//  DHClaendarCell.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHCalendarDateCell.h"

@implementation DHCalendarDateCell
@dynamic day;
@dynamic weekType;
@dynamic monthType;
@dynamic markToday;
@dynamic markMemo;

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
    _labelDay.text = @"";
    _labelDay.textColor = [UIColor blackColor];
    _labelDay.alpha = 1.0;
    _bIsMarkedToday = NO;
    self.backgroundColor = [UIColor whiteColor];
    self.monthType = kCurrentMonth;
    self.highlighted = NO;
    self.selected = NO;
    
    if (_defaultFont) {
        _labelDay.font = _defaultFont;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    // 하이라이트
    if (highlighted) {
        self.backgroundColor = [UIColor grayColor];
        return;
    }

    // 하이라이트 해제
    if (_bIsMarkedToday) {
        self.backgroundColor = [UIColor greenColor];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setSelected:(BOOL)selected
{
    if (!selected) {
        return;
    }

    // 해당하는 월로 이동
    //NSLog(@"self.monthType=%d", self.monthType);
    if (self.delegate && self.monthType == kPreviousMonth) {
        [self.delegate CalendarControlMoveToPreviousMonth];
    }
    if (self.delegate && self.monthType == kNextMonth) {
        [self.delegate CalendarControlMoveToNextMonth];
    }
    
    // 메모기능 처리
}

#pragma mark - setter/getter

// day
- (void)setDay:(NSString *)day
{
    _labelDay.text = day;
}

- (NSString*)day
{
    return _labelDay.text;
}

// weekType
- (void)setWeekType:(WeekType)weekType
{
    if (weekType == kFirstDay) {
        _labelDay.textColor = [UIColor redColor];
    }
    else if (weekType == kLastDay) {
        _labelDay.textColor = [UIColor blueColor];
    }
    else if (weekType == kWeekDays) {
        _labelDay.textColor = [UIColor blackColor];
    }
    else {
        // do nothing
    }
}

- (WeekType)weekType
{
    WeekType retType = kWeekDays;
    if ([_labelDay.textColor isEqual:[UIColor redColor]]) {
        retType = kFirstDay;
    }
    else if ([_labelDay.textColor isEqual:[UIColor blueColor]]) {
        retType = kLastDay;
    }
    else if ([_labelDay.textColor isEqual:[UIColor blackColor]]) {
        retType = kWeekDays;
    }
    else {
        // do nothing
    }
    
    return retType;
}

// monthType
- (void)setMonthType:(MonthType)monthType
{
    _monthType = monthType;
    
    if (monthType == kPreviousMonth) {
        _labelDay.alpha = 0.5;
    }
    else if (monthType == kCurrentMonth) {
        _labelDay.alpha = 1.0;
    }
    else if (monthType == kNextMonth) {
        _labelDay.alpha = 0.4;
    }
    else {
        // do nothing
    }
}

- (MonthType)monthType
{
    return _monthType;
}

// markToday
- (void)setMarkToday:(BOOL)markToday
{
    if (markToday) {
        self.backgroundColor = [UIColor greenColor];
        _bIsMarkedToday = YES;
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
        _bIsMarkedToday = NO;
    }
}

- (BOOL)markToday
{
    return _bIsMarkedToday;
}

// markMemo
- (void)setMarkMemo:(BOOL)markMemo
{
    if (markMemo) {
        // 메모가 있으면 폰트 굵게, 자주색으로 변경
        _labelDay.textColor = [UIColor purpleColor];
        if (!_defaultFont) {
            _defaultFont = _labelDay.font;
        }
        _labelDay.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
        _bIsMarkedMemo = YES;
    }
}

- (BOOL)markMemo
{
    return _bIsMarkedMemo;
}

@end
