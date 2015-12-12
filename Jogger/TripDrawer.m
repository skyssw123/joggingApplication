//
//  TripDrawer.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-05.
//  Copyright © 2015 sin. All rights reserved.
//

#import "TripDrawer.h"
#import "Pin.h"
#import "SpeedEvent.h"

@implementation TripDrawer
- (id)initWithTrip:(Trip*)trip withMapView:(MKMapView*)mapView
{
    if(trip == nil)
        return nil;
    self = [super init];
    if(self)
    {
        int i = 0;
        int j = 0;
        _speedEventArray = [trip.speedEvents copy];
        _speedEventlineArray = [[NSMutableArray alloc]init];
        _brakingEventArray = [trip.brakingEvents copy];
        _brakingEventlineArray = [[NSMutableArray alloc]init];
        CLLocationCoordinate2D coordinates[trip.allLocs.count];
        
        
        
        for (CLLocation *currentPin in trip.allLocs) {
            coordinates[i] = currentPin.coordinate;
            i ++;
    	}
        i = 0;
        
        _trip = trip;
        _polyline = [MKPolyline polylineWithCoordinates:coordinates count:trip.allLocs.count];
        
        for(; i < _speedEventArray.count; i++)
        {
            j = 0;
            SpeedEvent* speedEvent = _speedEventArray[i];
            CLLocationCoordinate2D speedingCoordinates[((SpeedEvent*)trip.speedEvents[i]).locationArray.count];
            for(; j < speedEvent.locationArray.count; j++)
            {
                 speedingCoordinates[j] = ((CLLocation *)speedEvent.locationArray[j]).coordinate;
            }
            _speedEventlineArray[i] = [MKPolyline polylineWithCoordinates:speedingCoordinates count:j];
        }
        
        i = 0;
        for(; i < _brakingEventArray.count; i++)
        {
            j = 0;
            SpeedEvent* brakingEvent = _brakingEventArray[i];
            CLLocationCoordinate2D brakingCoordinates[((SpeedEvent*)trip.brakingEvents[i]).locationArray.count];
            for(; j < brakingEvent.locationArray.count; j++)
            {
                brakingCoordinates[j] = ((CLLocation *)brakingEvent.locationArray[j]).coordinate;
            }
            _brakingEventlineArray[i] = [MKPolyline polylineWithCoordinates:brakingCoordinates count:j];
        }

        _mapView = mapView;
        return self;
    }
    
    return nil;
}


- (void)drawLineAtOnceWithColor
{
    if(self == nil)
        return ;
    
    // create an array of coordinates from allPins
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm, MMM dd, yyyy"];
    Pin* startPin = [[Pin alloc]initWithCoordinate:self.trip.startLoc.coordinate withTitle:@"START" withSubtitle:[df stringFromDate:self.trip.startLoc.timestamp]];
    [self.mapView addAnnotation:startPin];
    
    Pin* endPin = [[Pin alloc]initWithCoordinate:self.trip.endLoc.coordinate withTitle:@"END" withSubtitle:[df stringFromDate:self.trip.endLoc.timestamp]];
    [self.mapView addAnnotation:endPin];
    self.polyline.title = @"routeLine";
    [self.mapView addOverlay:self.polyline];
}

- (void)drawSpeedingEvents
{
    if(self == nil)
        return ;
    
    
    for(int i = 0; i < self.speedEventlineArray.count; i++)
    {
        ((MKPolyline*)self.speedEventlineArray[i]).title = @"speedLine";
        [self.mapView addOverlay:((MKPolyline*)self.speedEventlineArray[i])];
    }
}

- (void)drawBrakingEvents
{
    if(self == nil)
        return ;
    
    
    for(int i = 0; i < self.brakingEventlineArray.count; i++)
    {
        ((MKPolyline*)self.brakingEventlineArray[i]).title = @"brakeLine";
        [self.mapView addOverlay:((MKPolyline*)self.brakingEventlineArray[i])];
    }
}

- (void)removeOverlay
{
    [self.mapView removeOverlay:self.polyline];
}
@end
