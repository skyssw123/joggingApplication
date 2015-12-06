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
    NSMutableArray* returnArray = [[NSMutableArray alloc]init];
    Trip* trip;
    
    if(period == lastTrip)
    {
        while((line = [reader readLine]))
        {
            if([line isEqualToString:@"START OF TRIP\n"])
            {
                selectedTrip ++;
                continue;
            }
            
            
            if(selectedTrip == period)
            {
                NSArray* components = [line componentsSeparatedByString:@","];
                NSArray* timestampArray = [(NSString*)[components objectAtIndex:0] componentsSeparatedByString:@"="];
                NSString* timestampString = [timestampArray objectAtIndex:1];
                
                NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];
                NSDate* date = [formatter dateFromString:timestampString];
                
                NSArray* latitudeArray = [(NSString*)[components objectAtIndex:1] componentsSeparatedByString:@"="];
                NSString* latitudeString = [latitudeArray objectAtIndex:1];
                
                NSArray* longitudeArray = [(NSString*)[components objectAtIndex:2] componentsSeparatedByString:@"="];
                NSString* longitudeString = [longitudeArray objectAtIndex:1];
                
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([latitudeString doubleValue], [longitudeString doubleValue]);
                
                NSArray* speedArray = [(NSString*)[components objectAtIndex:3] componentsSeparatedByString:@"="];
                NSString* speedString = [speedArray objectAtIndex:1];
                
                NSArray* horizontalAccuracyArray = [(NSString*)[components objectAtIndex:4] componentsSeparatedByString:@"="];
                NSString* horizontalAccuracyString = [horizontalAccuracyArray objectAtIndex:1];
                
                NSArray* verticalAccuracyArray = [(NSString*)[components objectAtIndex:5] componentsSeparatedByString:@"="];
                NSString* verticalAccuracyString = [verticalAccuracyArray objectAtIndex:1];
                
                NSArray* altitudeArray = [(NSString*)[components objectAtIndex:6] componentsSeparatedByString:@"="];
                NSString* altitudeString = [(NSArray*)[[altitudeArray objectAtIndex:1] componentsSeparatedByString:@"\n"] objectAtIndex:0] ;
                
                CLLocation* location = [[CLLocation alloc]initWithCoordinate:coordinate altitude:[altitudeString doubleValue] horizontalAccuracy:[horizontalAccuracyString doubleValue] verticalAccuracy:[verticalAccuracyString doubleValue] course:0 speed:[speedString doubleValue] timestamp:date];
                [returnArray addObject:location];
            }
        }
        
        trip = [[Trip alloc]initWithLocations:returnArray];
    }
    //return trip;
    return trip;
}
@end
