//
//  LTTimerViewController.m
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import "LTTimerViewController.h"
#import "LTTimesViewController.h"
#import "LTChallenge.h"
#import "LTTime.h"

typedef NS_ENUM(NSInteger, LTTimerState) {
	LTTimerStateStopped,
	LTTimerStateRunning,
	LTTimerStateFinished
};

@interface LTTimerViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) LTTimerState state;
@property (nonatomic) NSTimeInterval currentTime;
@property (nonatomic, strong) NSDate *timerStartDate;
@property (nonatomic, strong) NSDateFormatter *timeFormatter;

// User Interface

@property (nonatomic, weak) IBOutlet UILabel *stopWatchLabel;
@property (nonatomic, weak) IBOutlet UIButton *stopWatchButton;

@property (nonatomic, weak) IBOutlet UILabel *bestTimeLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *bestTimeProgressView;
@property (nonatomic, weak) IBOutlet UILabel *worstTimeLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *worstTimeProgressView;
@property (nonatomic, weak) IBOutlet UILabel *averageTimeLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *averageTimeProgressView;
@property (nonatomic, weak) IBOutlet UILabel *currentTimeLabel;
@property (nonatomic, weak) IBOutlet UIProgressView *currentTimeProgressView;

@end

@implementation LTTimerViewController

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	self.state = LTTimerStateStopped;
	self.currentTime = 0.0;

	[self refreshTimerDisplay];

	self.navigationItem.title = self.challenge.name;
}

#pragma mark - Timer

- (void)updateTimer:(NSTimer *)timer
{
	self.currentTime = [[NSDate date] timeIntervalSinceDate:self.timerStartDate];
	[self refreshTimerDisplay];
}

- (void)refreshTimerDisplay
{
	self.stopWatchLabel.text = [self.timeFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.currentTime]];

	NSTimeInterval maxTime = self.currentTime;

	if ([self.challenge numberOfTimes] > 0) {
		LTTime *bestTime = [self.challenge bestTime];
		LTTime *worstTime = [self.challenge worstTime];
		NSTimeInterval averageDuration = [self.challenge averageTime];

		if (worstTime.duration > maxTime) maxTime = worstTime.duration;

		self.bestTimeLabel.text = [self formatTimeInterval:bestTime.duration];
		self.bestTimeProgressView.progress = bestTime.duration / maxTime;

		self.worstTimeLabel.text = [self formatTimeInterval:worstTime.duration];
		self.worstTimeProgressView.progress = worstTime.duration / maxTime;

		self.averageTimeLabel.text = [self formatTimeInterval:averageDuration];
		self.averageTimeProgressView.progress = averageDuration / maxTime;
	} else {
		self.bestTimeLabel.text = @"00:00:0";
		self.bestTimeProgressView.progress = 0.0;

		self.worstTimeLabel.text = @"00:00:0";
		self.worstTimeProgressView.progress = 0.0;

		self.averageTimeLabel.text = @"00:00:0";
		self.averageTimeProgressView.progress = 0.0;
	}

	self.currentTimeLabel.text = [self formatTimeInterval:self.currentTime];
	self.currentTimeProgressView.progress = self.currentTime / maxTime;
}

#pragma mark - Accessors

- (NSDateFormatter *)timeFormatter
{
	if (!_timeFormatter) {
		_timeFormatter = [[NSDateFormatter alloc] init];
		_timeFormatter.dateFormat = @"mm:ss:S";
	}
	return _timeFormatter;
}

#pragma mark - UI Actions

- (IBAction)toggleTimer:(id)sender
{
	switch (self.state) {
		case LTTimerStateStopped: // Start the timer
			self.currentTime = 0.0;
			self.timerStartDate = [NSDate date];
			self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05
														  target:self
														selector:@selector(updateTimer:)
														userInfo:nil
														 repeats:YES];
			self.state = LTTimerStateRunning;
			[self.stopWatchButton setTitle:@"Stop" forState:UIControlStateNormal];
			break;
		case LTTimerStateRunning: // Stop the timer
			[self.timer invalidate];
			self.timer = nil;
			self.state = LTTimerStateFinished;
			[self saveCurrentTime];
			[self.stopWatchButton setTitle:@"Clear" forState:UIControlStateNormal];
			break;
		case LTTimerStateFinished: // Clear current time
			self.currentTime = 0.0;
			[self refreshTimerDisplay];
			self.state = LTTimerStateStopped;
			[self.stopWatchButton setTitle:@"Start" forState:UIControlStateNormal];
			break;

		default:
			break;
	}
}

- (void)saveCurrentTime
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save Time"
														message:@"Do you want to save this time?"
													   delegate:self
											  cancelButtonTitle:@"Dismiss"
											  otherButtonTitles:@"Save", nil];
	alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
	[alertView show];
}

// Allows us to unwind from a segue back to this view controller
- (IBAction)unwindFromTimesView:(UIStoryboardSegue *)segue {}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1) { // Save
		LTTime *time = [[LTTime alloc] init];
		time.duration = self.currentTime;
		time.dateRecorded = [NSDate date];
		time.comment = [[alertView textFieldAtIndex:0] text];
		[self.challenge addTime:time];

		[self refreshTimerDisplay];
	}
}

#pragma mark - Utilities

- (NSString *)formatTimeInterval:(NSTimeInterval)interval
{
	NSDate *time = [NSDate dateWithTimeIntervalSince1970:interval];
	return [self.timeFormatter stringFromDate:time];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"showTimes"]) {
		UINavigationController *navVC = segue.destinationViewController;
		LTTimesViewController *timesVC = (LTTimesViewController *)navVC.topViewController;
		timesVC.challenge = self.challenge;

	}
}

@end
