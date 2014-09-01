//
//  LTTime.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  An `LTTime` represents an attempt at an `LTChallenge`, including the time of
 *  the attempt, its duration, and an optional comment.
 */
@interface LTTime : NSObject <NSCoding>

/** The duration of this event */
@property (nonatomic) NSTimeInterval duration;

/** When this event happened */
@property (nonatomic, strong) NSDate *dateRecorded;

/** An optional comment associated with this account. May be an empty string. */
@property (nonatomic, strong) NSString *comment;

@end
