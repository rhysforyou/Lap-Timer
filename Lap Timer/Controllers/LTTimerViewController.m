//
//  LTTimerViewController.m
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import "LTTimerViewController.h"

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

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.state = LTTimerStateStopped;
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
			break;
		case LTTimerStateRunning: // Stop the timer
			[self.timer invalidate];
			self.timer = nil;
			self.state = LTTimerStateFinished;
			[self saveCurrentTime];
			break;
		case LTTimerStateFinished: // Clear current time
			self.currentTime = 0.0;
			self.state = LTTimerStateStopped;
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
	[alertView show];
}

// Allows us to unwind from a segue back to this view controller
- (IBAction)unwindFromTimesView:(UIStoryboardSegue *)segue {}

@end
