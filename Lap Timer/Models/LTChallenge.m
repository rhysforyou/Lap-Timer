//
//  LTChallenge.m
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import "LTChallenge.h"
#import "LTTime.h"

@implementation LTChallenge

- (instancetype)initWithName:(NSString *)name
{
	if (self = [super init]) {
		_name = name;
		_times = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)addTime:(LTTime *)time
{
	[self.times addObject:time];
}

- (LTTime *)timeAtIndex:(NSInteger)index
{
	return self.times[index];
}

- (NSInteger)numberOfTimes
{
	return [self.times count];
}

- (LTTime *)bestTime
{
	return [[self.times sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return ((LTTime *)obj1).duration > ((LTTime *)obj2).duration;
	}] firstObject];
}

- (LTTime *)worstTime
{
	return [[self.times sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return ((LTTime *)obj1).duration < ((LTTime *)obj2).duration;
	}] firstObject];
}

- (NSTimeInterval)averageTime
{
	return [[self.times valueForKeyPath:@"@avg.duration"] doubleValue];
}

@end
