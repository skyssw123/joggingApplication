//
//  TripFactory.h
//  Jogger
//
//  Created by Thomas Sin on 2015-12-01.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trip.h"
#import "DDFileReader.h"
#import "FileLogging.h"
typedef enum
{
    noTrip = 0,
    lastTrip = 1,
}TripPeriod;

@interface TripFactory : NSObject
+(Trip*)produceTripWithLogs:(TripPeriod)period;
+(Trip*)produceTripWithLocations:(NSMutableArray*)allLocs;
@end
