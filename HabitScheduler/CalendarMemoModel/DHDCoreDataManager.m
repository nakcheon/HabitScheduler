//
//  DHDCoreDataManager.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/16/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHDCoreDataManager.h"
#import <CoreData/CoreData.h>
#import "DHDMemo.h"

#pragma mark - enum Definition

/******************************************************************************
 * enum Definition
 *****************************************************************************/


/******************************************************************************
 * String Definition
 *****************************************************************************/


/******************************************************************************
 * Constant Definition
 *****************************************************************************/


/******************************************************************************
 * Function Definition
 *****************************************************************************/


/******************************************************************************
 * Type Definition
 *****************************************************************************/

@interface DHDCoreDataManager(PrivateMethod)
// Private Methods
- (BOOL)privateCreate;
@end

@interface DHDCoreDataManager(ProcessMethod)
// processing methods
@end

/******************************************************************************************
 * Implementation
 ******************************************************************************************/
@implementation DHDCoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - class life cycle

- (id)init
{
    self = [super init];
    if (self) {
        [self privateCreate];
    }
    return self;
}

- (void)dealloc
{
    // do nothing
}

#pragma mark - private functions

- (BOOL)privateCreate
{
    return YES;
}

#pragma mark - operations

- (BOOL)addMemoWithYear:(NSString*)year
              withMonth:(NSString*)month
                withDay:(NSString*)day
               withMemo:(NSString*)memo
{
    DHDMemo* memoObject = [NSEntityDescription insertNewObjectForEntityForName:@"DHDMemo"
                                                        inManagedObjectContext:self.managedObjectContext];
    memoObject.year = year;
    memoObject.month = month;
    memoObject.day = day;
    memoObject.memo = memo;
    memoObject.insertDate = [NSDate date];
    
    [self saveContext];
    
    return YES;
}

- (BOOL)removeMemo:(DHDMemo*)memoObject
{
    [self.managedObjectContext deleteObject:memoObject];
    
    [self saveContext];
    
    return YES;
}

- (NSArray*)MemosWithYear:(NSString*)year
                withMonth:(NSString*)month
                  withDay:(NSString*)day   
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"year = %@ and month = %@ and day = %@", year, month, day];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription* entity = [NSEntityDescription entityForName:@"DHDMemo"
                                              inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
	
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"insertDate" ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	
	[fetchRequest setFetchBatchSize:20];
	[fetchRequest setFetchLimit:0];
	
	NSError* error = nil;
	NSArray* fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	if (!fetchedObjects) {
        return nil;
	}
    
	return fetchedObjects;
}

- (NSInteger)MemoCountWithYear:(NSString*)year
                     withMonth:(NSString*)month
                       withDay:(NSString*)day
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"year = %@ and month = %@ and day = %@", year, month, day];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription* entity = [NSEntityDescription entityForName:@"DHDMemo"
                                              inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
	
	[fetchRequest setFetchLimit:0];
	
	NSError* error = nil;
	NSUInteger fetchedCount = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
	
	return fetchedCount;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext * managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CalendarMemoModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL* documentURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL* storeURL = [documentURL URLByAppendingPathComponent:@"CalendarMemoModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Static methods (for singleton pattern)

static DHDCoreDataManager* instance = nil;

+ (DHDCoreDataManager*)sharedManager
{
    if (instance == nil) {
        @synchronized(self) {
            if (instance == nil) {
                instance = [[self alloc] init];
            }
        }
    }
    return instance;
}

+ (void)destroySharedManager
{
    // instance 변수에 nil을 대입하면, 해당 클래스에 dealloc 이 호출된다.
    // 해당 클래스에 dealloc 이 호출되면, 삭제해야할 객체들을 안에서 삭제한다.
    instance = nil;
}

@end
