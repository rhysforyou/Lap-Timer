//
//  LTChallengesViewController.m
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import "LTChallengesViewController.h"
#import "LTModel.h"
#import "LTChallenge.h"
#import "LTTimerViewController.h"

@interface LTChallengesViewController () <UIAlertViewDelegate>

@end

@implementation LTChallengesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.model numberOfChallenges];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"challengeCell" forIndexPath:indexPath];
	LTChallenge *challenge = [self.model challengeAtIndex:indexPath.row];

	cell.textLabel.text = challenge.name;
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self performSegueWithIdentifier:@"showTimer" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTimer"]) {
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		LTChallenge *challenge = [self.model challengeAtIndex:indexPath.row];
		LTTimerViewController *timerVC = (LTTimerViewController *)segue.destinationViewController;
		timerVC.challenge = challenge;
	}
}

#pragma mark - UI Actions

- (IBAction)createChallenge:(id)sender
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New Challenge"
														message:@"Enter a name for your challenge"
													   delegate:self
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:@"Save", nil];
	alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
	[alertView show];
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1) {
		UITextField *textInput = [alertView textFieldAtIndex:0];
		LTChallenge *challenge = [[LTChallenge alloc] initWithName:textInput.text];
		[self.model addChallenge:challenge];
		NSIndexPath *newRowIndexPath = [NSIndexPath indexPathForRow:[self.model numberOfChallenges]-1 inSection:0];
		[self.tableView insertRowsAtIndexPaths:@[newRowIndexPath]
							  withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

@end
