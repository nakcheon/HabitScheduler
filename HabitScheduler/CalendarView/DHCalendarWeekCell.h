//
//  DHCalendarCell.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHCalendarDefine.h"

@interface DHCalendarWeekCell : UICollectionViewCell
{
    IBOutlet UILabel* _labelWeek;
}
@property (nonatomic, copy) NSString* week;
@property (nonatomic, assign) WeekType weekType;

@end
