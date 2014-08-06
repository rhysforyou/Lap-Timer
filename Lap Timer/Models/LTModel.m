//
//  LTModel.m
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import "LTModel.h"

@implementation LTModel

- (void)addChallenge:(LTChallenge *)challenge
{
	[self.challenges addObject:challenge];
}

- (LTChallenge *)challengeAtIndex:(NSInteger)index
{
	return self.challenges[index];
}

- (NSInteger)numberOfChallenges
{
	return [self.challenges count];
}

@end
