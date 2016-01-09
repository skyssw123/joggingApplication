//
//  TripFactory.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-01.
//  Copyright © 2015 sin. All rights reserved.
//

#import "TripFactory.h"
#import "Settings.h"

@implementation TripFactory

+(Trip*)produceTripWithLogs:(TripPeriod)period
{
    int selectedTrip = 0;
    FileLogging* sharedInstance = [FileLogging sharedInstance];
    NSString* fileName;
    if(period == firstTrip)
        fileName = DEFAULT_FIRST_TRIP_FILENAME;
    else if(period == secondTrip)
        fileName = DEFAULT_SECOND_TRIP_FILENAME;
    else if(period == lastTrip)
    {
        fileName = DEFAULT_LAST_TRIP_FILENAME;
        if(![sharedInstance fileExists:fileName])
        {
            fileName = DEFAULT_SECOND_TRIP_FILENAME;
            if(![sharedInstance fileExists:fileName])
                fileName = DEFAULT_FIRST_TRIP_FILENAME;
        }
    }
    
    else if(period == currentTrip)
    {
        fileName = DEFAULT_FILENAME;
        if(![sharedInstance fileExists:fileName])
        {
            return nil;
        }
    }
    
    if(![sharedInstance fileExists:fileName])
    {
        //error banner goes in here (No Data)
        return nil;
    }
    
    NSString* filePath = [NSString stringWithFormat:@"%@/%@", sharedInstance.dirPath, fileName];
    DDFileReader * reader = [[DDFileReader alloc] initWithFilePath:filePath];
    NSString * line = nil;
    NSMutableArray* returnArray = [[NSMutableArray alloc]init];
    Trip* trip;
    

    while((line = [reader readLine]))
    {
        if(line == nil)
            continue;
            
        else if ([line isEqualToString:@"\n"])
            continue;
            
        if([line isEqualToString:@"START OF TRIP\n"])
        {
            continue;
        }
        
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
    
    if(returnArray == nil)
        return nil;
    
    trip = [[Trip alloc]initWithLocations:returnArray];
    //return trip;
    return trip;
}

+(Trip*)produceTripWithLocations:(NSMutableArray*)allLocs
{
    return [[Trip alloc]initWithLocations:allLocs];
}
@end
