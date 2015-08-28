//
//  DHCalendarMemoViewController.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHCalendarSubViewControlDelegate.h"

@interface DHCalendarMemoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    IBOutlet UILabel* _lblTitle;
    IBOutlet UITableView* _tblMemo;

    // memo
    UIAlertView* _alertMemoInput;
    UITextField* _textfileldMemoInput;
    
    NSMutableArray* _toc;
}
@property (nonatomic, assign) id<DHCalendarSubViewControlDelegate> subViewControlDelegate;
@property (nonatomic, copy) NSString* year;
@property (nonatomic, copy) NSString* month;
@property (nonatomic, copy) NSString* day;

@end
