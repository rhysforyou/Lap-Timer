//
//  LTModel.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTChallenge;

/**
 *  Represents a collection of `LTChallenge` objects
 */
@interface LTModel : NSObject <NSCoding>

/**
 *  Add a challenge to the model
 *
 *  @param challenge the challenge to add
 */
- (void)addChallenge:(LTChallenge *)challenge;

/**
 *  Get the challenge at a given index
 *
 *  @param index the index of the challenge
 *
 *  @return the challenge at that index
 */
- (LTChallenge *)challengeAtIndex:(NSInteger)index;

/**
 *  Get the number of challenges stored in this model
 *
 *  @return the number of challenges
 */
- (NSInteger)numberOfChallenges;

@end
