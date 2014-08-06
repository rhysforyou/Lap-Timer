//
//  LTTime.h
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTTime : NSObject <NSCoding>

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic, strong) NSDate *dateRecorded;
@property (nonatomic, strong) NSString *comment;

@end
