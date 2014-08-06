//
//  LTModel.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTChallenge;

@interface LTModel : NSObject <NSCoding>

@property (nonatomic, strong) NSMutableArray *challenges;

- (void)addChallenge:(LTChallenge *)challenge;
- (LTChallenge *)challengeAtIndex:(NSInteger)index;
- (NSInteger)numberOfChallenges;

@end
