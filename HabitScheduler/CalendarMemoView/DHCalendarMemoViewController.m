//
//  DHCalendarMemoViewController.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHCalendarMemoViewController.h"
#import "DHMemoCell.h"
#import "DHMemoEmptyCell.h"
#import "DHDCoreDataManager.h"
#import "DHDMemo.h"

#pragma mark - enum Definition

/******************************************************************************
 * enum Definition
 *****************************************************************************/
// Alert type
enum TagAlertType {
    TagAlretMemoInput = 0,
};

/******************************************************************************
 * String Definition
 *****************************************************************************/


/******************************************************************************
 * Constant Definition
 *****************************************************************************/
#define kTableCellHeight 100

/******************************************************************************
 * Type Definition
 *****************************************************************************/

@interface DHCalendarMemoViewController(PrivateMethod)
// Private Methods
- (BOOL)privateCreate;
- (BOOL)privateCreateAddMemoView;
@end

@interface DHCalendarMemoViewController(ProcessMethod)
// processing methods
- (BOOL)processClose;
- (BOOL)processSaveMemoWithMemo:(NSString*)memo;
- (BOOL)processDeleteMemo:(NSInteger)index;
@end

/******************************************************************************************
 * Implementation
 ******************************************************************************************/
@implementation DHCalendarMemoViewController

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
    
    [self privateCreate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 메모리에서 내려갈때 떠있는 alert 창을 닫아주지 않으면 다시 앱을 올릴때 앱이 죽는다.
    if (_alertMemoInput) {
        [_alertMemoInput dismissWithClickedButtonIndex:-1 animated:NO];
        _alertMemoInput = nil;
    }
}

#pragma mark - UITableViewDataSource delegation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_toc count] == 0) {
        return 1;
    }
    return [_toc count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 목차가 비어있을때는 빈셀을 보여준다.
    if ([_toc count] == 0) {
        static NSString* CellIdentifier = @"DHMemoEmptyCell";
        DHMemoEmptyCell* emptyCell = (DHMemoEmptyCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!emptyCell) {
            emptyCell = [[[NSBundle mainBundle] loadNibNamed:@"DHMemoEmptyCell" owner:nil options:nil] objectAtIndex:0];
        }
        return emptyCell;
    }
    
    static NSString* CellIdentifier = @"DHMemoCell";
    DHMemoCell* cell = (DHMemoCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DHMemoCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    // set data
    DHDMemo* memoObject = [_toc objectAtIndex:indexPath.row];
    cell.time = [NSString stringWithFormat:@"%@%@ %@%@ %@%@",
                 memoObject.year, NSLocalizedString(@"년", @""),
                 memoObject.month, NSLocalizedString(@"월", @""),
                 memoObject.day, NSLocalizedString(@"일", @"")];
    cell.memo = memoObject.memo;
    
    return cell;
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 셀 지우기
        [self processDeleteMemo:indexPath.row];
    }
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    return nil;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView*)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)sectionIndex
{
    return 0;
}

#pragma mark - UITableViewDelegate delegation

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([_toc count] == 0) {
        return _tblMemo.frame.size.height;
    }
    
    return kTableCellHeight;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    // do nothing
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSInteger tag = alertView.tag;
    
    // 그룹추가 성공/실패시
	if (tag == TagAlretMemoInput) {
        if (buttonIndex == 0/*확인*/) {
            [self processSaveMemoWithMemo:_textfileldMemoInput.text];
        }
    }
    [_textfileldMemoInput removeFromSuperview];
    _textfileldMemoInput =  nil;
    _alertMemoInput = nil;
}

#pragma mark - IBAction methods

- (IBAction)backButtonPressed:(id)sender
{
    [self processClose];
}

- (IBAction)addMemoButtonPressed:(id)sender
{
    [self privateCreateAddMemoView];
}

#pragma mark - private functions

- (BOOL)privateCreate
{
    _lblTitle.text = [NSString stringWithFormat:@"%@년 %@월 %@일", self.year, self.month, self.day];
    
    _toc = [NSMutableArray arrayWithArray:[[DHDCoreDataManager sharedManager] MemosWithYear:self.year withMonth:self.month withDay:self.day]];
    
    return YES;
}

- (BOOL)privateCreateAddMemoView
{
    // 6.x 대 이하 일때
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        // Ask for Username and password.
        UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"메모를 입력해주세요.", @"")
                                                            message:@"\n"
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"확인", @"")
                                                  otherButtonTitles:NSLocalizedString(@"취소", @""), nil];
        
        // Adds a 북마크 제목 Field
        if (_textfileldMemoInput) {
            _textfileldMemoInput = nil;
        }
        _textfileldMemoInput = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
        _textfileldMemoInput.placeholder = NSLocalizedString(@"메모없음", @"");
        [_textfileldMemoInput setBackgroundColor:[UIColor whiteColor]];
        _textfileldMemoInput.borderStyle = UITextBorderStyleRoundedRect;
        _textfileldMemoInput.clearButtonMode=YES;
        _textfileldMemoInput.clearsOnBeginEditing=YES;
        [alertview addSubview:_textfileldMemoInput];
        
        // show keyboard
        [_textfileldMemoInput becomeFirstResponder];
        
        // Show alert on screen.
        alertview.tag = TagAlretMemoInput;
        [alertview show];
        _alertMemoInput = alertview;
        alertview = nil;
    }
    
    // 7.x 대 이상 일때
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"메모를 입력해주세요.", @"")
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"확인", @"")
                                                  otherButtonTitles:NSLocalizedString(@"취소", @""), nil];
        
        alertview.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertview textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;
        
        CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 0.0);
        [alertview setTransform: moveUp];
        [alertview show];
        
        _textfileldMemoInput = [alertview textFieldAtIndex:0];
        _textfileldMemoInput.placeholder = NSLocalizedString(@"메모없음", @"");
        _alertMemoInput = alertview;
        alertview = nil;
    }
    
    return YES;
}

#pragma mark - process functions

- (BOOL)processClose
{
    // remove view
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self.view removeFromSuperview];
                         
                         if (self.subViewControlDelegate) {
                             [self.subViewControlDelegate subViewControllerClosed:self];
                         }
                     }];
    
    return YES;
}

- (BOOL)processSaveMemoWithMemo:(NSString*)memo
{
    if (!memo || [memo isEqualToString:@""]) {
        return NO;
    }
    
    BOOL ret = [[DHDCoreDataManager sharedManager] addMemoWithYear:self.year
                                                     withMonth:self.month
                                                       withDay:self.day
                                                      withMemo:memo];
    if (ret) {
        _toc = [NSMutableArray arrayWithArray:[[DHDCoreDataManager sharedManager] MemosWithYear:self.year withMonth:self.month withDay:self.day]];
        [_tblMemo reloadData];
    }
    
    return ret;
}

- (BOOL)processDeleteMemo:(NSInteger)index
{
    // 코어데이터 객체 삭제
    DHDMemo* memoObject = [_toc objectAtIndex:index];
    [[DHDCoreDataManager sharedManager] removeMemo:memoObject];
    
    // UI 갱신
    [_toc removeObjectAtIndex:index];
    [_tblMemo reloadData];
    
    
    return YES;
}


@end
