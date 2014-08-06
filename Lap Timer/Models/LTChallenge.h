//
//  LTChallenge.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTTime;

@interface LTChallenge : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *times;

- (instancetype)initWithName:(NSString *)name;

- (void)addTime:(LTTime *)time;
- (LTTime *)timeAtIndex:(NSInteger)index;
- (NSInteger)numberOfTimes;

- (LTTime *)bestTime;
- (LTTime *)worstTime;
- (NSTimeInterval)averageTime;

@end
