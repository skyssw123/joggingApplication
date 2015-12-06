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
        NSMutableArray* speedEventArray = [[NSMutableArray alloc]init];
        
        double distance;
        double time;
        double speed;
        CLLocation* currentLoc;
        CLLocation* prevLoc = _startLoc;
        CLLocation* prevSpeedingLoc = _startLoc;
        NSUInteger count = [locs count];
        int j = 0;
        for(int i = 1; i <= count-1 ; i++)
        {
            currentLoc = [_allLocs objectAtIndex:i];
            distance = [currentLoc distanceFromLocation:prevLoc];
            _totalDistance += distance;
            speed = currentLoc.speed;
            if(speed > 3.0)
            {
                if(j == 0)
                    prevSpeedingLoc = currentLoc;
                time = ([currentLoc.timestamp timeIntervalSince1970] - [prevSpeedingLoc.timestamp timeIntervalSince1970]) * 1000;
                if(time < 2000)
                    [speedEventArray addObject:currentLoc];
                else
                {
                    SpeedEvent* speedEvent = [[SpeedEvent alloc]initWithLocationArray:speedEventArray];
                    [_speedEvents addObject:speedEvent];
                    speedEventArray = [[NSMutableArray alloc]init];
                    [speedEventArray addObject:currentLoc];
                }
                prevSpeedingLoc = currentLoc;
                j++;
            }
            prevLoc = currentLoc;
        }
        SpeedEvent* speedEvent = [[SpeedEvent alloc]initWithLocationArray:speedEventArray];
        [_speedEvents addObject:speedEvent];
        
        _avgVelocity = _totalDistance / _totalTimeInMiliSeconds * 1000.0;
    }
    return self;
}
@end

