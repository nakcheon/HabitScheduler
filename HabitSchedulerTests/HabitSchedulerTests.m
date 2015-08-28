//
//  HabitSchedulerTests.m
//  HabitSchedulerTests
//
//  Created by NakCheonJung on 11/26/13.
//  Copyright (c) 2013 DailyHabitCoding. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DHDCoreDataManager.h"
#import "DHDMemo.h"

@interface HabitSchedulerTests : XCTestCase
{
    NSInteger _initialCount;
}

@end

@implementation HabitSchedulerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _initialCount = [[DHDCoreDataManager sharedManager] MemoCountWithYear:@"9999" withMonth:@"11" withDay:@"15"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testA_AddData
{
    NSLog(@"%@ start", self.name);
    [[DHDCoreDataManager sharedManager] addMemoWithYear:@"9999"
                                              withMonth:@"11"
                                                withDay:@"15"
                                               withMemo:@"11111111"];
    NSLog(@"%@ end", self.name);
}

- (void)testB_ReadData
{
    NSLog(@"%@ start", self.name);
    NSMutableArray* _toc = [NSMutableArray arrayWithArray:[[DHDCoreDataManager sharedManager] MemosWithYear:@"9999"
                                                                                                  withMonth:@"11"
                                                                                                    withDay:@"15"]];
    XCTAssert([_toc count] == (_initialCount), @"Fail Count, its not %d, count is %d", _initialCount, [_toc count]);
    
    DHDMemo* memoObject = [_toc lastObject];
    XCTAssertNotNil(memoObject, @"Fail, memoObject is nil");
    
    XCTAssert([memoObject.year isEqualToString:@"9999"], @"Fail year data, its not 9999");
    XCTAssert([memoObject.month isEqualToString:@"11"], @"Fail month data, its not 11");
    XCTAssert([memoObject.day isEqualToString:@"15"], @"Fail day data, its not 15");
    XCTAssert([memoObject.memo isEqualToString:@"11111111"], @"Fail day data, its not 11111111");
    NSLog(@"%@ end", self.name);
}

- (void)testC_DeleteData
{
    NSLog(@"%@ start", self.name);
    NSMutableArray* _toc = [NSMutableArray arrayWithArray:[[DHDCoreDataManager sharedManager] MemosWithYear:@"9999"
                                                                                                  withMonth:@"11"
                                                                                                    withDay:@"15"]];
    DHDMemo* memoObject = [_toc lastObject];
    XCTAssertNotNil(memoObject, @"Fail, memoObject is nil");
    
    [_toc removeObject:memoObject];
    [[DHDCoreDataManager sharedManager] removeMemo:memoObject];
    
    XCTAssert([_toc count] == _initialCount-1, @"Fail Count, its not 0");
    NSLog(@"%@ end", self.name);
}


@end
