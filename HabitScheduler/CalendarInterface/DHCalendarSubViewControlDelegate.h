//
//  DHCalendarSubViewControlDelegate.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/16/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHCalendarSubViewControlDelegate <NSObject>

- (void)subViewClosed:(UIView*)view;
- (void)subViewControllerClosed:(UIViewController*)viewController;

@end
