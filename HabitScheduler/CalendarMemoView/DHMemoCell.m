//
//  DHMemoCell.m
//  HabitScheduler
//
//  Created by NakCheonJung on 11/15/13.
//  Copyright (c) 2013 CoupangTest. All rights reserved.
//

#import "DHMemoCell.h"

@implementation DHMemoCell
@dynamic time;
@dynamic memo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter/getter

// time
- (void)setTime:(NSString *)time
{
    _lblTime.text = time;
}

- (NSString*)time
{
    return _lblTime.text;
}

// memo
- (void)setMemo:(NSString *)memo
{
    _lblMemo.text = memo;
}

- (NSString*)memo
{
    return _lblMemo.text;
}

@end
