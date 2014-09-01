//
//  LTChallengesViewController.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTModel;

/**
 *  Displays a list of challenges
 */
@interface LTChallengesViewController : UITableViewController

/** The model to get the list of challenges from */
@property (nonatomic, strong) LTModel *model;

@end
