//
//  LTChallenge.m
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import "LTChallenge.h"

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

@end
