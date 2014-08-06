//
//  LTChallenge.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTTime;

@interface LTChallenge : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *times;

- (void)addTime:(LTTime *)time;

- (instancetype)initWithName:(NSString *)name;

@end
