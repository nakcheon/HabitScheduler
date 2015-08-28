//
//  DHCalendarDayModel.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHCalendarDayModel : NSObject

+ (NSString*)descriptionWithYear:(NSString*)year
                       withMonth:(NSString*)month
                         atIndex:(NSInteger)index;

@end
