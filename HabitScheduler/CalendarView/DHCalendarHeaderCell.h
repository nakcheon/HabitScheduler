//
//  DHCalendarHeaderCell.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHCalendarControlDeleate.h"

@interface DHCalendarHeaderCell : UICollectionReusableView
{
    IBOutlet UILabel* _labelYearMonth;
}
@property (nonatomic, copy) NSString* yearMonth;
@property (nonatomic, weak) id<DHCalendarControlDeleate> delegate;

@end
