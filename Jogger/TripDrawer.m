//
//  TripDrawer.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-05.
//  Copyright © 2015 sin. All rights reserved.
//

#import "TripDrawer.h"
#import "Pin.h"

@implementation TripDrawer
- (id)initWithTrip:(Trip*)trip withMapView:(MKMapView*)mapView
{
    if(trip == nil)
        return nil;
    self = [super init];
    if(self)
    {
        int i = 0;
        _speedEventlineArray = [[NSMutableArray alloc]init];
        CLLocationCoordinate2D coordinates[trip.allLocs.count];
        CLLocationCoordinate2D speedCoordinates[trip.speedEvents.count];
        for (CLLocation *currentPin in trip.allLocs) {
            coordinates[i] = currentPin.coordinate;
            i ++;
    	}
        i = 0;
        for(CLLocation* loc in trip.speedEvents)
        {
            speedCoordinates[i] = loc.coordinate;
            i ++;
        }
        
        _trip = trip;
        _polyline = [MKPolyline polylineWithCoordinates:coordinates count:trip.allLocs.count];
        _speedEventlineArray[0] = [MKPolyline polylineWithCoordinates:speedCoordinates count:trip.speedEvents.count];

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

    Pin* startPin = [[Pin alloc]initWithCoordinate:self.trip.startLoc.coordinate withTitle:@"START" withSubtitle:@"hello"];
    [self.mapView addAnnotation:startPin];
    
    Pin* endPin = [[Pin alloc]initWithCoordinate:self.trip.endLoc.coordinate withTitle:@"END" withSubtitle:@"hello"];
    [self.mapView addAnnotation:endPin];
    self.polyline.title = @"routeLine";
    [self.mapView addOverlay:self.polyline];
}

- (void)drawSpeedingEvents
{
    if(self == nil)
        return ;
    
    ((MKPolyline*)self.speedEventlineArray[0]).title = @"speedLine";
    [self.mapView addOverlay:((MKPolyline*)self.speedEventlineArray[0])];
}

- (void)removeOverlay
{
    [self.mapView removeOverlay:self.polyline];
}
@end
