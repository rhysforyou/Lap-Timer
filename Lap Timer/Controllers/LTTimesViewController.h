//
//  LTTimesViewController.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTChallenge;

/** Shows a list of all attempts on a given challenge. */
@interface LTTimesViewController : UITableViewController

/** The challenge to list attempts for */
@property (nonatomic, strong) LTChallenge *challenge;

@end
