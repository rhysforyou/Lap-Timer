//
//  LTTime.m
//  Lap Timer
//
//  Created by Rhys Powell on 6/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

#import "LTTime.h"

@implementation LTTime

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super init]) {
		_duration = [aDecoder decodeDoubleForKey:@"duration"];
		_dateRecorded = [aDecoder decodeObjectForKey:@"dateRecorded"];
		_comment = [aDecoder decodeObjectForKey:@"comment"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeDouble:self.duration forKey:@"duration"];
	[aCoder encodeObject:self.dateRecorded forKey:@"dateRecorded"];
	[aCoder encodeObject:self.comment forKey:@"comment"];
}

@end
