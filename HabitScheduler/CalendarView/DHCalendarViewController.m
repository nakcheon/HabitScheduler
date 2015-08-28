//
//  DHCalendarViewController.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

// view
#import "DHCalendarViewController.h"
#import "DHCalendarDateCell.h"
#import "DHCalendarWeekCell.h"
#import "DHCalendarMemoViewController.h"
// model
#import "DHCalendarWeekModel.h"
#import "DHCalendarDayModel.h"
#import "DHCalendarDateModel.h"
#import "DHCalendarUtilityForDate.h"
#import "DHDCoreDataManager.h"
// constants
#import "DHCalendarDefine.h"

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
 * Type Definition
 *****************************************************************************/

@interface DHCalendarViewController(PrivateMethod)
// Private Methods
- (BOOL)privateCreate;
- (UICollectionViewCell*)privateCreateWeekDayCellAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionViewCell*)privateCreateDayCellAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView*)privateCreateDayHeaderCellAtIndexPath:(NSIndexPath *)indexPath kind:(NSString*)elementKind;
- (NSInteger)privateCalculateTotalDays;
- (BOOL)privateReInitializeDateDatas:(NSInteger)year WithMonth:(NSInteger)month;
- (BOOL)privateIsWeekDaysCell:(NSIndexPath *)indexPath;
// memo
- (BOOL)privateCreateMemoViewController:(NSIndexPath *)indexPath;
@end

/******************************************************************************************
 * Implementation
 ******************************************************************************************/
@implementation DHCalendarViewController

#pragma mark - class life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    // 초기화
    [self privateCreate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self privateCalculateTotalDays];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"collectiionView::cellForItemAtIndexPath;indexpath = %d, %d", indexPath.section, indexPath.row);
    
    UICollectionViewCell* cell = nil;
    
    // 인덱스 0~7은 월화수목금 을 나타내는 요일
    if ([self privateIsWeekDaysCell:indexPath]) {
        cell = [self privateCreateWeekDayCellAtIndexPath:indexPath];
    }
    
    // 나머지 인덱스는 날짜 표시
    else {
        cell = [self privateCreateDayCellAtIndexPath:indexPath];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"collectiionView::viewForSupplementaryElementOfKind;indexpath = %d, %d", indexPath.section, indexPath.row);
    
    UICollectionReusableView* headerCell = nil;
    
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        headerCell = [self privateCreateDayHeaderCellAtIndexPath:indexPath kind:kind];
    }

    return headerCell;
}

#pragma mark - UICollectionViewDelegate

// Methods for notification of selection/deselection and highlight/unhighlight events.
// The sequence of calls leading to selection from a user touch is:
//
// (when the touch begins)
// 1. -collectionView:shouldHighlightItemAtIndexPath:
// 2. -collectionView:didHighlightItemAtIndexPath:
//
// (when the touch lifts)
// 3. -collectionView:shouldSelectItemAtIndexPath: or -collectionView:shouldDeselectItemAtIndexPath:
// 4. -collectionView:didSelectItemAtIndexPath: or -collectionView:didDeselectItemAtIndexPath:
// 5. -collectionView:didUnhighlightItemAtIndexPath:
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"shouldHighlightItemAtIndexPath: (%d)", indexPath.row - NUM_OF_WEEK_DAYS);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"didHighlightItemAtIndexPath: (%d)", indexPath.row - NUM_OF_WEEK_DAYS);
    
    // 하이라이트 처리
    if (![self privateIsWeekDaysCell:indexPath]) {
        DHCalendarDateCell* dateCell = (DHCalendarDateCell*)[_calendar cellForItemAtIndexPath:indexPath];
        dateCell.highlighted = YES;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"didUnhighlightItemAtIndexPath: (%d)", indexPath.row - NUM_OF_WEEK_DAYS);
    
    // 하이라이트 처리
    if (![self privateIsWeekDaysCell:indexPath]) {
        DHCalendarDateCell* dateCell = (DHCalendarDateCell*)[_calendar cellForItemAtIndexPath:indexPath];
        dateCell.highlighted = NO;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"shouldSelectItemAtIndexPath: (%d)", indexPath.row - NUM_OF_WEEK_DAYS);
    return YES;
}

// called when the user taps on an already-selected item in multi-select mode
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"shouldDeselectItemAtIndexPath: (%d)", indexPath.row - NUM_OF_WEEK_DAYS);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"didSelectItemAtIndexPath: (%d)", indexPath.row - NUM_OF_WEEK_DAYS);
    
    // 클릭 터치 처리
    if ([self privateIsWeekDaysCell:indexPath]) {
        return;
    }
    
    // 이전달 또는 다음달이면 메모추가 뷰를 보이지 않는다.
    DHCalendarDateCell* dateCell = (DHCalendarDateCell*)[_calendar cellForItemAtIndexPath:indexPath];
    if (dateCell.monthType == kPreviousMonth || dateCell.monthType == kNextMonth) {
        return;
    }
    
    // show memo view contoller
    [self privateCreateMemoViewController:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"didDeselectItemAtIndexPath: (%d)", indexPath.row - NUM_OF_WEEK_DAYS);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"didEndDisplayingCell: (%d)", indexPath.row - NUM_OF_WEEK_DAYS);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    
}

// These methods provide support for copy/paste actions on cells.
// All three should be implemented if any are.
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    
}

// support for custom transition layout
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
    return nil;
}

#pragma mark - DHCalendarControlDeleate

- (void)CalendarControlMoveToPreviousMonth
{
    // 인덱스 계산
    NSInteger currentYear = [_currentYear integerValue];
    NSInteger currentMonth = [_currentMonth integerValue];
    --currentMonth;
    if (currentMonth < 1) {
        currentMonth = NUM_OF_MONTHS;
        --currentYear;
    }
    
    // 다시 날짜 값 처리
    [self privateReInitializeDateDatasWithYear:currentYear WithMonth:currentMonth];
    
    // 다시 그리기
    [_calendar reloadData];
}

- (void)CalendarControlMoveToNextMonth
{
    // 인덱스 계산
    NSInteger currentYear = [_currentYear integerValue];
    NSInteger currentMonth = [_currentMonth integerValue];
    ++currentMonth;
    if (currentMonth > NUM_OF_MONTHS) {
        currentMonth = 1;
        ++currentYear;
    }
    
    // 다시 날짜 값 처리
    [self privateReInitializeDateDatasWithYear:currentYear WithMonth:currentMonth];
    
    // 다시 그리기
    [_calendar reloadData];
}

#pragma mark - DHCalendarSubViewControlDelegate


- (void)subViewClosed:(UIView*)view
{
    
}

- (void)subViewControllerClosed:(UIViewController*)viewController
{
    if ([_viewMemo isEqual:viewController]) {
        [_viewMemo.view removeFromSuperview];
        _viewMemo = nil;
        
        // 다시 그리기 - 메모가 추가되었을 경우를 검사하여 UI 변경해야하기 때문에
        [_calendar reloadData];
    }
}

#pragma mark - private functions

- (BOOL)privateCreate
{
    if (!_currentYear) {
        _currentYear = [DHCalendarUtilityForDate getTodayYear];
    }
    if (!_currentMonth) {
        _currentMonth = [DHCalendarUtilityForDate getTodayMonth];
    }
    if (!_currentDay) {
        _currentDay = [DHCalendarUtilityForDate getToday];
    }
    
    return YES;
}

- (UICollectionViewCell*)privateCreateWeekDayCellAtIndexPath:(NSIndexPath *)indexPath
{
    DHCalendarWeekCell* weekCell = [_calendar dequeueReusableCellWithReuseIdentifier:@"weekCell"
                                                                             forIndexPath:indexPath];
    
    // 일요일/토요일 색상 표시
    weekCell.week = [DHCalendarWeekModel descriptionAtIndex:indexPath.row];
    if (indexPath.row % NUM_OF_WEEK_DAYS == 0) {
        weekCell.weekType = kFirstDay;
    }
    else if (indexPath.row % NUM_OF_WEEK_DAYS == (NUM_OF_WEEK_DAYS-1)) {
        weekCell.weekType = kLastDay;
    }
    else {
        // do nothing
    }
    return weekCell;
}

- (UICollectionViewCell*)privateCreateDayCellAtIndexPath:(NSIndexPath *)indexPath;
{
    DHCalendarDateCell* dateCell = [_calendar dequeueReusableCellWithReuseIdentifier:@"dateCell"
                                                                             forIndexPath:indexPath];
    dateCell.delegate = self;
    
    // 값 처리
    dateCell.day = [DHCalendarDayModel descriptionWithYear:_currentYear
                                                withMonth:_currentMonth
                                                  atIndex:indexPath.row-NUM_OF_WEEK_DAYS];
    
    // 오늘 처리
    if ([dateCell.day isEqualToString:_currentDay]) {
        dateCell.markToday = YES;
    }
    
    // 일요일/토요일 색상 표시
    if (indexPath.row % NUM_OF_WEEK_DAYS == 0) {
        dateCell.weekType = kFirstDay;
    }
    else if (indexPath.row % NUM_OF_WEEK_DAYS == (NUM_OF_WEEK_DAYS-1)) {
        dateCell.weekType = kLastDay;
    }
    else {
        // do nothing
    }
    
    // 이전달/다음달 알파 표시
    //NSLog(@"_indexOfFirstDay + _daysInCurrentMonth=%d", _indexOfFirstDay + _daysInCurrentMonth);
    if (indexPath.row - NUM_OF_WEEK_DAYS < _indexOfFirstDay) {
        dateCell.monthType = kPreviousMonth;
    }
    else if (indexPath.row - NUM_OF_WEEK_DAYS > _indexOfFirstDay + _daysInCurrentMonth - 1) {
        dateCell.monthType = kNextMonth;
    }
    else {
        dateCell.monthType = kCurrentMonth;
    }
    
    // 메모 여부 검사하여 표시 - 현재 달에만 보여준다.
    if (dateCell.monthType == kCurrentMonth) {
        NSInteger memoCount = [[DHDCoreDataManager sharedManager] MemoCountWithYear:_currentYear
                                                                          withMonth:_currentMonth
                                                                            withDay:dateCell.day];
        if (memoCount > 0) {
            dateCell.markMemo = YES;
        }
    }
    
    return dateCell;
}

- (UICollectionReusableView*)privateCreateDayHeaderCellAtIndexPath:(NSIndexPath *)indexPath
                                                              kind:(NSString*)elementKind
{
    DHCalendarHeaderCell* headerCell = [_calendar dequeueReusableSupplementaryViewOfKind:elementKind
                                                                     withReuseIdentifier:@"headerCell"
                                                                            forIndexPath:indexPath];
    headerCell.delegate = self;
    headerCell.yearMonth = [DHCalendarDateModel descriptionWithYear:_currentYear
                                                             withMonth:_currentMonth];
    
    return headerCell;
}

- (NSInteger)privateCalculateTotalDays
{
    NSInteger indexOfFirstDay = [DHCalendarUtilityForDate getIndexOfWeekWithYear:_currentYear
                                                                       withMonth:_currentMonth
                                                                         withDay:@"01"] - 1;
    
    NSInteger daysInCurrentMonth = [DHCalendarUtilityForDate getNumberOfDaysWithYear:_currentYear
                                                                           withMonth:_currentMonth
                                                                             withDay:@"01"];
    
    NSInteger indexOfLastDay = [DHCalendarUtilityForDate getIndexOfWeekWithYear:_currentYear
                                                                       withMonth:_currentMonth
                                                                         withDay:[NSString stringWithFormat:@"%d", daysInCurrentMonth]];
    
    
    NSInteger days =  indexOfFirstDay + daysInCurrentMonth + (NUM_OF_WEEK_DAYS-indexOfLastDay) + NUM_OF_WEEK_DAYS;
    
    _daysInCurrentMonth = daysInCurrentMonth;
    _indexOfFirstDay = indexOfFirstDay;
    _indexOfLastDay = indexOfLastDay;
    
    return days;
}

- (BOOL)privateReInitializeDateDatasWithYear:(NSInteger)year WithMonth:(NSInteger)month
{
    _currentYear = [NSString stringWithFormat:@"%d", year];
    _currentMonth = [NSString stringWithFormat:@"%d", month];
    
    if ([_currentYear isEqualToString:[DHCalendarUtilityForDate getTodayYear]] &&
        [_currentMonth isEqualToString:[DHCalendarUtilityForDate getTodayMonth]]
        ) {
        _currentDay = [DHCalendarUtilityForDate getToday];
    }
    else {
        _currentDay = @"";
    }
    
    return YES;
}

- (BOOL)privateIsWeekDaysCell:(NSIndexPath *)indexPath
{
    return (indexPath.row >= 0 && indexPath.row < NUM_OF_WEEK_DAYS);
}

- (BOOL)privateCreateMemoViewController:(NSIndexPath *)indexPath
{
    // show memo view contoller
    DHCalendarMemoViewController* viewController = [[DHCalendarMemoViewController alloc] initWithNibName:@"DHCalendarMemoViewController" bundle:nil];
    
    viewController.subViewControlDelegate = self;
    viewController.year = _currentYear;
    viewController.month = _currentMonth;
    
    DHCalendarDateCell* dateCell = (DHCalendarDateCell*)[_calendar cellForItemAtIndexPath:indexPath];
    viewController.day = dateCell.day;
    
    // add view
    viewController.view.alpha = 0.0;
    [self.view addSubview:viewController.view];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         viewController.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         // do nothing
                     }];
    
    _viewMemo = viewController;
    viewController = nil;
    
    return YES;
}

@end
