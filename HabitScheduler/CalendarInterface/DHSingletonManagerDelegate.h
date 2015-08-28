//
//  DHSingletonManagerDelegate.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/16/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DHSingletonManagerDelegate <NSObject>

+ (id)sharedManager;
+ (void)destroySharedManager;

@end
