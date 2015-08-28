//
//  DHMemoCell.h
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHMemoCell : UITableViewCell
{
    IBOutlet UILabel* _lblTime;
    IBOutlet UILabel* _lblMemo;
}
@property (nonatomic, copy) NSString* time;
@property (nonatomic, copy) NSString* memo;

@end
