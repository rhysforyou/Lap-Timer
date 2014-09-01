//
//  LTAppDelegate.m
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import "LTAppDelegate.h"
#import "LTModel.h"
#import "LTChallenge.h"
#import "LTChallengesViewController.h"

@interface LTAppDelegate ()

@property (nonatomic, strong) LTModel *lapTimerModel;

@end

@implementation LTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:69.0/255.0 green: 48.0/255.0 blue: 67.0/255.0 alpha: 1.0]];

	// Load saved data from the last time the app was active
	self.lapTimerModel = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];

	// If this is the first run, we'll seed the app with some default challenges
	if (!self.lapTimerModel) {
		self.lapTimerModel = [[LTModel alloc] init];
		[self.lapTimerModel addChallenge:[[LTChallenge alloc] initWithName:@"Clap 20 Times"]];
		[self.lapTimerModel addChallenge:[[LTChallenge alloc] initWithName:@"Say the Alphabet"]];
		[self.lapTimerModel addChallenge:[[LTChallenge alloc] initWithName:@"100 Metre Sprint"]];
		[self.lapTimerModel addChallenge:[[LTChallenge alloc] initWithName:@"Read the CSCI342 Spec"]];
	}

	// Pass the challenges to our
	UINavigationController *navVC = (UINavigationController *)[self.window rootViewController];
	LTChallengesViewController *challengesVC = (LTChallengesViewController *)[navVC topViewController];
	challengesVC.model = self.lapTimerModel;

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Save the challenges and times to an archive
	[NSKeyedArchiver archiveRootObject:self.lapTimerModel toFile:[self archivePath]];
}

/** Get the path for the app's archive file */
- (NSString *)archivePath
{
	NSString *directory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
	return [NSString stringWithFormat:@"%@/LapTimer.archive", directory];
}

@end
