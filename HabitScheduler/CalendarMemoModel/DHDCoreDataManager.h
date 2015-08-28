//
//  DHDCoreDataManager.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/16/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHSingletonManagerDelegate.h"

@class DHDMemo;

@interface DHDCoreDataManager : NSObject <DHSingletonManagerDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (BOOL)addMemoWithYear:(NSString*)year
              withMonth:(NSString*)month
                withDay:(NSString*)day
               withMemo:(NSString*)memo;
- (BOOL)removeMemo:(DHDMemo*)memoObject;
- (NSArray*)MemosWithYear:(NSString*)year
                withMonth:(NSString*)month
                  withDay:(NSString*)day;
- (NSInteger)MemoCountWithYear:(NSString*)year
                     withMonth:(NSString*)month
                       withDay:(NSString*)day;

//============================================================
// singleton supprot
//============================================================
+ (DHDCoreDataManager*)sharedManager;
+ (void)destroySharedManager;

@end
