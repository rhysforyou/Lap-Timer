//
//  LTTimerViewController.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTChallenge;

/**
 *  Displays a challenge's best, worst, and average times as well as allowing 
 *  the user to add new times.
 */
@interface LTTimerViewController : UIViewController

/** The challenge to manage times for */
@property (nonatomic, strong) LTChallenge *challenge;

@end
