//
//  DHCalendarDateCell.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHCalendarDefine.h"
#import "DHCalendarControlDeleate.h"

@interface DHCalendarDateCell : UICollectionViewCell
{
    IBOutlet UILabel* _labelDay;
    UIFont* _defaultFont;
    
    BOOL _bIsMarkedToday;
    BOOL _bIsMarkedMemo;
    MonthType _monthType;
}
@property (nonatomic, copy) NSString* day;
@property (nonatomic, assign) WeekType weekType;
@property (nonatomic, assign) MonthType monthType;
@property (nonatomic, assign) BOOL markToday;
@property (nonatomic, assign) BOOL markMemo;
@property (nonatomic, weak) id<DHCalendarControlDeleate> delegate;

@end
