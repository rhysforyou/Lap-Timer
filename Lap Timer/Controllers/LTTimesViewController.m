//
//  LTTimesViewController.m
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import "LTTimesViewController.h"
#import "LTChallenge.h"
#import "LTTime.h"

@interface LTTimesViewController ()


@property (nonatomic, strong) NSDateFormatter *timeFormatter;

@end

@implementation LTTimesViewController

#pragma mark - Accessors

- (NSDateFormatter *)timeFormatter
{
	if (!_timeFormatter) {
		_timeFormatter = [[NSDateFormatter alloc] init];
		_timeFormatter.dateFormat = @"mm:ss:S";
	}
	return _timeFormatter;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.challenge numberOfTimes];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell" forIndexPath:indexPath];
	LTTime *time = [self.challenge timeAtIndex:indexPath.row];

	cell.textLabel.text = time.comment;
	cell.detailTextLabel.text = [self formatTimeInterval:time.duration];

    return cell;
}

#pragma mark - Utilities

- (NSString *)formatTimeInterval:(NSTimeInterval)interval
{
	NSDate *time = [NSDate dateWithTimeIntervalSince1970:interval];
	return [self.timeFormatter stringFromDate:time];
}

@end
