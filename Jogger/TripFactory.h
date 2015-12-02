//
//  TripFactory.h
//  Jogger
//
//  Created by Thomas Sin on 2015-12-01.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trip.h"
typedef enum
{
    lastTrip = 0,
}TripPeriod;

@interface TripFactory : NSObject
-(Trip*)readTrip:(TripPeriod)period;
@end
