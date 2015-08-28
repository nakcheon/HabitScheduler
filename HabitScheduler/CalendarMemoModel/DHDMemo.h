//
//  DHDMemo.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/16/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DHDMemo : NSManagedObject

@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * month;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSDate * insertDate;

@end
