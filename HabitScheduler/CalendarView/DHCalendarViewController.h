//
//  DHCalendarViewController.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHCalendarHeaderCell.h"
#import "DHCalendarSubViewControlDelegate.h"

@class DHCalendarMemoViewController;

@interface DHCalendarViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, DHCalendarControlDeleate, DHCalendarSubViewControlDelegate>
{
    IBOutlet UICollectionView* _calendar;
    DHCalendarMemoViewController* _viewMemo;
    
    NSString* _currentYear;
    NSString* _currentMonth;
    NSString* _currentDay;
    
    NSInteger _indexOfFirstDay;
    NSInteger _indexOfLastDay;
    NSInteger _daysInCurrentMonth;
}

@end
