//
//  Trip.m
//  Jogger
//
//  Created by Thomas Sin on 2015-11-30.
//  Copyright © 2015 sin. All rights reserved.
//

#import "Trip.h"

@implementation Trip
-(id)initWithLocations:(NSMutableArray*)locs
{
    self = [super init];
    if(self)
    {
        if(locs == nil || locs.count == 0)
            return nil;
        _allLocs = [NSArray arrayWithArray:locs];
        _startLoc = [_allLocs firstObject];
        _endLoc = [_allLocs lastObject];
        _totalTimeInMiliSeconds = ([_endLoc.timestamp timeIntervalSince1970] - [_startLoc.timestamp timeIntervalSince1970]) * 1000.0;
        _speedEvents = [[NSMutableArray alloc]init];
        
        double distance;
        double time;
        double speed;
        CLLocation* currentLoc;
        CLLocation* prevLoc = _startLoc;
        NSUInteger count = [locs count];
        
        for(int i = 1; i <= count-1 ; i++)
        {
            currentLoc = [_allLocs objectAtIndex:i];
            distance = [currentLoc distanceFromLocation:prevLoc];
            _totalDistance += distance;
            time = [currentLoc.timestamp timeIntervalSince1970] - [prevLoc.timestamp timeIntervalSince1970];
            speed = currentLoc.speed;
            if(speed > 3.0)
            {
                [_speedEvents addObject:currentLoc];
            }
            prevLoc = currentLoc;
        }
        
        _avgVelocity = _totalDistance / _totalTimeInMiliSeconds * 1000.0;
    }
    return self;
}
@end

