//
//  Trip.h
//  Jogger
//
//  Created by Thomas Sin on 2015-11-30.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "SpeedEvent.h"

@interface Trip : NSObject
-(id)initWithLocations:(NSMutableArray*)locs;
@property (strong, nonatomic) NSArray* allLocs;
@property double totalTimeInMiliSeconds;
@property double totalDistance;
@property double avgVelocity;
@property double avgAccel;
@property (strong, nonatomic) CLLocation* startLoc;
@property (strong, nonatomic) CLLocation* endLoc;
@property (strong, nonatomic) NSMutableArray* speedEvents;
@property (strong, nonatomic) NSMutableArray* brakingEvents;
@property (strong, nonatomic) NSMutableArray* accelEvents;
@end
