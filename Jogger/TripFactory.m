//
//  TripFactory.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-01.
//  Copyright © 2015 sin. All rights reserved.
//

#import "TripFactory.h"

@implementation TripFactory

+(Trip*)produceTrip:(TripPeriod)period
{
    int selectedTrip = 0;
    DDFileReader * reader = [[DDFileReader alloc] initWithFilePath:[FileLogging sharedInstance].filePath];
    NSString * line = nil;
    
    if(period == lastTrip)
    {
        while((line = [reader readLine]))
        {
            if([line isEqualToString:@"START OF TRIP\n"])
                selectedTrip ++;
            NSArray* array = [line componentsSeparatedByString:@" "];
            if(array.count == 1)
                break;
            
            
            
            if(selectedTrip == period)
            {
                NSArray* components = [line componentsSeparatedByString:@" "];
                //CLLocation* location = [[CLLocation alloc]initWithCoordinate:(CLLocationCoordinate2D) altitude:(CLLocationDistance) horizontalAccuracy:(CLLocationAccuracy) verticalAccuracy:(CLLocationAccuracy) timestamp:(nonnull NSDate *)]
            };
        }
    }
    //Trip* trip = [[Trip alloc]initWithLocations:];
    //return trip;
    return nil;
}
@end
