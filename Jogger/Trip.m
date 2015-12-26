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
        
        
        //NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
        //NSArray array = [NSArray arrayWithObject:sortDescriptor];
        _allLocs = [locs copy];
        //_allLocs = [_allLocs sortUsingDescriptors:array];

        
        _startLoc = [_allLocs firstObject];
        _endLoc = [_allLocs lastObject];
        _totalTimeInMiliSeconds = ([_endLoc.timestamp timeIntervalSince1970] - [_startLoc.timestamp timeIntervalSince1970]) * 1000.0;
        _speedEvents = [[NSMutableArray alloc]init];
        _brakingEvents = [[NSMutableArray alloc]init];
        NSMutableArray* speedEventArray = [[NSMutableArray alloc]init];
        NSMutableArray* brakingEventArray = [[NSMutableArray alloc]init];
        double distance;
        double time;
        double speed;
        CLLocation* currentLoc;
        CLLocation* prevLoc = _startLoc;
        CLLocation* prevSpeedingLoc = _startLoc;
        CLLocation* prevBrakingLoc = _startLoc;
        
        _maxLatitude = _startLoc.coordinate.latitude;
        _minLatitude = _startLoc.coordinate.latitude;
        _maxLongitude = _startLoc.coordinate.longitude;
        _minLongitude = _startLoc.coordinate.longitude;
        
        NSUInteger count = [locs count];
        int j = 0;
        int k = 0;
        for(int i = 1; i < count ; i++)
        {
            currentLoc = [_allLocs objectAtIndex:i];
            
            if(_maxLatitude < currentLoc.coordinate.latitude)
                _maxLatitude = currentLoc.coordinate.latitude;
            if(_minLatitude > currentLoc.coordinate.latitude)
                _minLatitude = currentLoc.coordinate.latitude;
            
            if(_maxLongitude < currentLoc.coordinate.longitude)
                _maxLongitude = currentLoc.coordinate.longitude;
            if(_minLongitude > currentLoc.coordinate.longitude)
                _minLongitude = currentLoc.coordinate.longitude;
            
            distance = [currentLoc distanceFromLocation:prevLoc];

            
            speed = currentLoc.speed;
            if(speed > 2.0)
            {
                if(j == 0)
                {
                    prevSpeedingLoc = currentLoc;
                }
                time = ([currentLoc.timestamp timeIntervalSince1970] - [prevSpeedingLoc.timestamp timeIntervalSince1970]) * 1000;
                if(time < 2000)
                    [speedEventArray addObject:currentLoc];
                else
                {
                    if(speedEventArray.count <= 5)
                    {
                        speedEventArray = [[NSMutableArray alloc]init];
                        [speedEventArray addObject:currentLoc];
                    }
                        
                    else
                    {
                        SpeedEvent* speedEvent = [[SpeedEvent alloc]initWithLocationArray:speedEventArray];
                        [_speedEvents addObject:speedEvent];
                        speedEventArray = [[NSMutableArray alloc]init];
                        [speedEventArray addObject:currentLoc];
                    }
                }
                prevSpeedingLoc = currentLoc;
                j++;
            }
            
            else if(speed == 0.0)
            {
                if(k == 0)
                {
                    prevBrakingLoc = currentLoc;
                }
                time = ([currentLoc.timestamp timeIntervalSince1970] - [prevBrakingLoc.timestamp timeIntervalSince1970]) * 1000;
                if(time < 2000)
                    [brakingEventArray addObject:currentLoc];
                else
                {
                    if(brakingEventArray.count <= 5)
                    {
                        brakingEventArray = [[NSMutableArray alloc]init];
                        [brakingEventArray addObject:currentLoc];
                    }
                    
                    else
                    {
                        SpeedEvent* brakingEvent = [[SpeedEvent alloc]initWithLocationArray:brakingEventArray];
                        [_brakingEvents addObject:brakingEvent];
                        brakingEventArray = [[NSMutableArray alloc]init];
                        [brakingEventArray addObject:currentLoc];
                    }
                }
                prevBrakingLoc = currentLoc;
                k++;
                distance = 0;
            }
            _totalDistance += distance;
            prevLoc = currentLoc;
        }
        SpeedEvent* speedEvent = [[SpeedEvent alloc]initWithLocationArray:speedEventArray];
        [_speedEvents addObject:speedEvent];
        
        SpeedEvent* brakingEvent = [[SpeedEvent alloc]initWithLocationArray:brakingEventArray];
        [_brakingEvents addObject:brakingEvent];
        
        _avgVelocity = _totalDistance / _totalTimeInMiliSeconds * 1000.0;
    }
    return self;
}
@end

