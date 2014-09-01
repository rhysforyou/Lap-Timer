//
//  LTChallenge.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTTime;

/**
 *  A challenge represents a goal, represented as the challenge's `name`, and 
 *  all the attempts made on that goal, stored as `LTTime` instances.
 */
@interface LTChallenge : NSObject <NSCoding>

/** The challenge's name, e.g. "Clap 20 Times" */
@property (nonatomic, strong) NSString *name;

/**
 *  Create a new challenge instance with the given name
 *
 *  @param name the name of this challenge
 *
 *  @return a newly initialised challenge
 */
- (instancetype)initWithName:(NSString *)name;

/**
 *  Add the given time to this challenge's history
 *
 *  @param time the time to add
 */
- (void)addTime:(LTTime *)time;

/**
 *  Get the time at the given index, throws an error if the specified index is
 *  out of range.
 *
 *  @param index the time's index
 *
 *  @return the time at that index
 */
- (LTTime *)timeAtIndex:(NSInteger)index;

/**
 *  Get the number of times that have been recorded
 *
 *  @return the number of times that have been recorded
 */
- (NSInteger)numberOfTimes;

/**
 *  Get the shortest time for this challenge
 *
 *  @return the LTTime object with the shortest time
 */
- (LTTime *)bestTime;

/**
 *  Get the longest time for this challenge
 *
 *  @return the LTTime object with the longest time
 */
- (LTTime *)worstTime;

/**
 *  Get the mean duration of all the recorded times
 *
 *  @return the mean duration of all the recorded times
 */
- (NSTimeInterval)averageTime;

@end
